//
//  NapTienLienThachViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import StoreKit

class NapTienLienThachViewController: BaseViewController {
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    
    let productId = "truyensieuhay.beblue.com.450"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "NẠP TIÊN LINH THẠCH $"
        if Session.shared.userProfile.Active == 0 {
            viewMobile.isHidden = true
            viewWallet.isHidden = true
            topSpace.constant = 0
        } else {
            viewMobile.isHidden = false
            viewWallet.isHidden = false
            topSpace.constant = 100
        }
    }
    
    @IBAction func actionNapThePhone(_ sender: Any) {
        let mobiCardVC = MobiCardViewController.instantiateViewControllerFromStoryboard(storyboardName: .more)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mobiCardVC, animated: true)
    }
    
    @IBAction func transferBankMOMO(_ sender: Any) {
        let bankWalletVC = BankAndWalletViewController.instantiateViewControllerFromStoryboard(storyboardName: .more)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bankWalletVC, animated: true)
    }
    
    @IBAction func requestProducts() {
        let listPurchaseVC = ListPurchaseViewController.instantiateViewControllerFromStoryboard(storyboardName: .more)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(listPurchaseVC, animated: true)
    }
}
