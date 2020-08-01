//
//  ChangePasswordViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    @IBOutlet weak var txtOldPassword: FWFloatingLabelTextField!
    @IBOutlet weak var txtNewPassword: FWFloatingLabelTextField!
    @IBOutlet weak var txtReNewPassword: FWFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    

    private func setupUI() {
        self.title = "Đổi mật khẩu"
    }
    
    private func isCheckfield() -> Bool {
        if txtOldPassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập mật khẩu cũ")
            return false
        }
        
        if txtNewPassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập mật khẩu mới")
            return false
        }
        
        if txtReNewPassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập lại mật khẩu mới")
            return false
        }
        
        if txtNewPassword.text! != txtReNewPassword.text! {
            Toast.showErr("Bạn chưa nhập mật khẩu mới giống nhau")
            return false
        }
        
        return true
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if isCheckfield() {
            
        }
        
        let param = ["userid": Session.shared.userProfile.Id, "oldpassword": txtOldPassword.text!, "newpassword": txtNewPassword.text!]
        self.showLoading()
        APIService.changePassword(param: param) { (response, message) in
            self.hideLoading()
            Toast.show(message ?? "Có lỗi xảy ra!")
        }
    }
    
}
