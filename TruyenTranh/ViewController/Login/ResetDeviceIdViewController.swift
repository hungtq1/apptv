//
//  ResetDeviceIdViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/28/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ResetDeviceIdViewController: UIViewController {
    @IBOutlet weak var txtEmail: FWFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "ĐĂNG XUẤT TẤT CẢ CÁC THIỆT BỊ"
    }
    
    @IBAction func resetDeviceID(_ sender: Any) {
        guard !txtEmail.text!.isEmpty else {
            Toast.showErr("Bạn chưa nhập email")
            return
        }
        
        guard (txtEmail.text?.isValidEmail())! else {
            Toast.showErr("Bạn nhập email chưa đúng định dạng")
            return
        }
        
        let param:[String: Any] = ["Email": txtEmail.text!]
        self.showLoading()
        APIService.resetDeviceID(param: param) { (response, message) in
            self.hideLoading()
            Toast.show(message ?? "Có lõi xảy ra!")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
