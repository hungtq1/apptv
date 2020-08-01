//
//  SignupViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/3/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var txtUsername: FWFloatingLabelTextField!
    @IBOutlet weak var txtPassword: FWFloatingLabelTextField!
    @IBOutlet weak var txtRePassword: FWFloatingLabelTextField!
    @IBOutlet weak var txtEmail: FWFloatingLabelTextField!
    @IBOutlet weak var txtGender: FWFloatingLabelTextField!
    var genderStr = ""
    var reloadData: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Đăng ký thành viên"
    }
    
    @IBAction func doRegister(_ sender: Any) {
        guard isCheckField() else {
            return
        }
        var uuid = ""
        let keyChain = Keychain(service: Constants.keyChainService)
        do {
            let uuidKeychain = try keyChain.get(Constants.UUID_STR)
            if let uuidStr = uuidKeychain?.fromBase64() {
                uuid = uuidStr
            } else {
                uuid = UUID().uuidString
                keyChain[Constants.UUID_STR] = uuid.toBase64()
            }
        } catch {
            Toast.showErr("Lỗi lưu dữ liệu vào keychain")
        }
        let param = ["username": txtUsername.text!, "password": txtPassword.text!, "email": txtEmail.text!, "gioitinh": "Nam", "mamay": uuid]
        self.showLoading()
        APIService.doRegister(param: param) { (userProfile, message) in
            self.hideLoading()
            if let userProfile = userProfile {
                UserDefaults.standard.set(self.txtUsername.text!, forKey: Constants.USERNAME)
                UserDefaults.standard.set(self.txtPassword.text!, forKey: Constants.PASSWORD)
                UserDefaults.standard.set(userProfile.token, forKey: Constants.TOKEN_KEY)
                UserDefaults.standard.set(userProfile.user.ID, forKey: Constants.USER_ID)
                UserDefaults.standard.synchronize()
                Session.shared.userLogin = userProfile
                Toast.showSuccess("Đăng ký thành công")
                if let block = self.reloadData {
                    block()
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                Toast.showErr(message ?? "Có lỗi xảy ra! Hãy thử lại")
            }
        }
    }
    
    private func isCheckField() -> Bool {
        if txtUsername.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập tên đăng nhập")
            return false
        }
        
        if !txtUsername.text!.isValidCharacter() {
            Toast.showErr("Tên đăng nhập (giới hạn ký tự từ a-z 0-9, tối đa 32 ký tự) bắt buộc")
            return false
        }
        
        if txtPassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập mật khẩu")
            return false
        }
        
        if txtPassword.text!.count < 6 {
            Toast.showErr("Mật khẩu tối thiểu 6 ký tự")
            return false
        }
        
        if txtRePassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập lại mật khẩu")
            return false
        }
        
        if txtEmail.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập email")
            return false
        }
        
        if !txtEmail.text!.isValidEmail() {
            Toast.showErr("Email nhập chưa đúng định dạng")
            return false
        }
        
        if txtPassword.text! != txtRePassword.text! {
            Toast.showErr("Mật khẩu bạn nhập chưa giống nhau")
            return false
        }
        return true
    }
    
    @IBAction func selectGender() {
        var alertController:UIAlertController? = nil
        if IS_IPAD{
            alertController = UIAlertController(title: nil, message: "Chọn giới tính", preferredStyle: .alert)
        }else{
            alertController = UIAlertController(title: nil, message: "Chọn giới tính", preferredStyle: .actionSheet)
        }
        alertController?.addAction(UIAlertAction(title: "Nam", style: .default, handler: { (action) in
            self.txtGender.text = "Nam"
        }))
        
        alertController?.addAction(UIAlertAction(title: "Nữ", style: .default, handler: { (action) in
            self.txtGender.text = "Nữ"
        }))
        
        alertController?.addAction(UIAlertAction(title: "Huỷ".localized, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alertController!, animated: true, completion: {
            print("completion block")
        })
    }
}
