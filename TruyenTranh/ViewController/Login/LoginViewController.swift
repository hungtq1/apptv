//
//  IPTVViewController.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import Material

class LoginViewController: BaseViewController {
    @IBOutlet weak var txtUsername: ErrorTextField!
    @IBOutlet weak var txtPassword: TextField!
    var reloadData: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        self.title = "Đăng nhập"
    }
    
    @IBAction func actionLogin(_ sender: Any) {
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
        
        let strEnc = try! (txtUsername.text! + "|" + txtPassword.text! + "|" + "\(Int(Date().timeIntervalSince1970 + 780) )" + "|" + uuid).aesEncrypt(key: Constants.KEY_ENCRYPT, iv: Constants.IV_ENCRYPT)
        let param = ["enc": strEnc.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "+", with: "-")]
        self.showLoading()
        APIService.doLogin(param: param) { (userProfile, message) in
            self.hideLoading()
            if let userProfile = userProfile {
                self.appDelegate.subscribeTopic(topic: "tsh_user_" + userProfile.user.ID)
                UserDefaults.standard.set(userProfile.token, forKey: Constants.TOKEN_KEY)
                UserDefaults.standard.set(self.txtUsername.text!, forKey: Constants.USERNAME)
                UserDefaults.standard.set(self.txtPassword.text!, forKey: Constants.PASSWORD)
                UserDefaults.standard.set(userProfile.user.ID, forKey: Constants.USER_ID)
                Session.shared.userLogin = userProfile
                UserDefaults.standard.synchronize()
                Toast.showSuccess("Đăng nhập thành công")
                NotificationCenter.default.post(name: .ReloadHomeView, object: nil)
                if let block = self.reloadData {
                    block()
                }
                self.navigationController?.popViewController(animated: true)
            } else {
                Toast.showErr(message ?? "Có lỗi xảy ra! Hãy thử lại")
            }
        }
    }
    
    @IBAction func actionRegister() {
        let registerVC = SignupViewController.instantiateViewControllerFromStoryboard(storyboardName: .signup)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    private func isCheckField() -> Bool {
        if txtUsername.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập tên đăng nhập")
            return false
        }
        
        if txtPassword.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập mật khẩu")
            return false
        }
        
        return true
    }
    
    @IBAction func openForgotPassword(_ sender: Any) {
        let forgotPassword = ForgotPasswordViewController.instantiateViewControllerFromStoryboard(storyboardName: .profile)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(forgotPassword, animated: true)
    }
    
    @IBAction func logoutAllDevice(_ sender: Any) {
        let resetDeviceID = ResetDeviceIdViewController.instantiateViewControllerFromStoryboard(storyboardName: .login)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(resetDeviceID, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
