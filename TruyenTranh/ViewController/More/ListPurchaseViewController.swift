//
//  ListPurchaseViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/29/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import StoreKit

class ListPurchaseViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var products: [SKProduct] = []
    var price = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.getListProduct()
    }
    
    private func setupUI() {
        self.title = "Danh sách mua"
        self.tableView.set(delegateAndDataSource: self)
    }
    
    private func getListProduct() {
        self.showLoading()
        TruyenSieuHayProducts.store.requestProducts { [weak self] success, products in
            self?.hideLoading()
            if let products = products, products.count > 0 {
                self?.products = products
                DispatchQueue.main.async {
                   self?.tableView.reloadData()
                }

            } else {
                Toast.show("Không có sản phẩm nào")
            }
        }
    }
}

extension ListPurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        
        cell.product = product
        cell.buyButtonHandler = { product in
          TruyenSieuHayProducts.store.buyProduct(product)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        self.price = Int(product.price)
        TruyenSieuHayProducts.store.buyProduct(product)
    }
}
