//
//  IAPHelper.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/17/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import StoreKit

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

extension Notification.Name {
  static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}

open class IAPHelper: NSObject  {
  
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    var transaction = SKPaymentTransaction()
    var price = 0
    public init(productIds: Set<ProductIdentifier>) {
    productIdentifiers = productIds
//    for productIdentifier in productIds {
//      let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
//      if purchased {
//        purchasedProductIdentifiers.insert(productIdentifier)
//        print("Previously purchased: \(productIdentifier)")
//      } else {
//        print("Not purchased: \(productIdentifier)")
//      }
//    }
    super.init()

    SKPaymentQueue.default().add(self)
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler

    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

  public func buyProduct(_ product: SKProduct) {
    UIViewController().topController().showLoading()
    print("Buying \(product.productIdentifier)...")
    price = Int(product.price)
    let payment = SKPayment(product: product)
    SKPaymentQueue.default().add(payment)
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return purchasedProductIdentifiers.contains(productIdentifier)
  }
  
  public class func canMakePayments() -> Bool {
    return SKPaymentQueue.canMakePayments()
  }
  
  public func restorePurchases() {
    SKPaymentQueue.default().restoreCompletedTransactions()
  }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {

  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    print("Loaded list of products...")
    let products = response.products
    productsRequestCompletionHandler?(true, products)
    clearRequestAndHandler()

    for p in products {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }
  }

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }

    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {

  public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
        UIViewController().topController().hideLoading()
        switch (transaction.transactionState) {
        case .purchased:
            complete(transaction: transaction)
            break
        case .failed:
            fail(transaction: transaction)
            break
        case .restored:
            restore(transaction: transaction)
            break
        case .deferred:
            break
        case .purchasing:
//        purchasing(transaction: transaction)
        break
        }
    }
  }

    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        self.transaction = transaction
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }

        print("restore... \(productIdentifier)")
        self.transaction = transaction
        deliverPurchaseNotificationFor(identifier: productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func purchasing(transaction: SKPaymentTransaction) {

        print("purchasing... \(transaction.payment.productIdentifier)")
        self.transaction = transaction
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        self.transaction = transaction
        if let transactionError = transaction.error as NSError?,
            let localizedDescription = transaction.error?.localizedDescription,
            transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }

        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func deliverPurchaseNotificationFor(identifier: String?) {
//        guard let identifier = identifier else { return }
//
//        purchasedProductIdentifiers.insert(identifier)
//        UserDefaults.standard.set(true, forKey: identifier)
        UIViewController().topController().hideLoading()
        NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
        self.sendPaymentInfor(transaction: self.transaction)
    }
    
    private func sendPaymentInfor(transaction: SKPaymentTransaction) {
        let userId = Session.shared.userProfile.Id
        let keyEncrypt = userId + "336ec2cd10d8313fdd1da9e928c58ba5"
        let transactionDate = String(format: "%.0f", transaction.transactionDate!.timeIntervalSince1970)
        let timeNow = String(format: "%.0f", Date().timeIntervalSince1970)
        print("Key encrypt: \(keyEncrypt)")
        print("Key encrypt md5: \(keyEncrypt.md5())")
        let strToEncrypt = "\(price)|\(transaction.transactionIdentifier ?? "")|\(transactionDate)|\(timeNow)"
        let strEnc = try! strToEncrypt.aesEncrypt(key: keyEncrypt.md5(), iv: Constants.IV_ENCRYPT).replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "+", with: "-")
        print("String to encrypt: \(strToEncrypt)")
        print("String encrypt: \(strEnc)")
        let strDecrypt = try! strEnc.aesDecrypt(key: keyEncrypt.md5(), iv: Constants.IV_ENCRYPT)
        print("String decrypt: \(strDecrypt)")
        let param = ["data": strEnc]
        UIViewController().topController().showLoading()
        APIService.sendPaymentInAppPurchase(param: param) { (response, message) in
            UIViewController().topController().hideLoading()
            if response != nil {
                Toast.showSuccess("Thanh toán thành công")
            } else {
                Toast.show(message ?? "Có lỗi xảy ra!")
            }
        }
    }
}

