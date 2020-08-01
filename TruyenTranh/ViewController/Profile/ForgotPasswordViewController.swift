//
//  ForgotPasswordViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/5/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var txtEmail: FWFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Quên mật khẩu"
        
    }
    
    @IBAction func executeForgotPassword(_ sender: Any) {
        let param = ["email": txtEmail.text!]
        self.showLoading()
        APIService.forgotPassword(param: param) { (response, message) in
            self.hideLoading()
            Toast.show(message!)
        }
    }
}
