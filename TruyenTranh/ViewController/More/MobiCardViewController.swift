//
//  MobiCardViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/8/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class MobiCardViewController: UIViewController {
    @IBOutlet weak var lblLoaiThe: UILabel!
    @IBOutlet weak var lblMenhGia: UILabel!
    @IBOutlet weak var txtMaTheCao: UITextField!
    @IBOutlet weak var txtSoSeri: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "NẠP THẺ CÀO ĐIỆN THOẠI"
        self.appDelegate.subscribeTopic(topic: "tsh_user_" + Session.shared.userProfile.Id)
    }
    
    @IBAction func selectMenhGia() {
        var alert:UIAlertController? = nil
        if IS_IPAD{
            alert = UIAlertController(title: nil, message: "Mệnh Giá Thẻ", preferredStyle: .alert)
        }else{
            alert = UIAlertController(title: nil, message: "Mệnh Giá Thẻ", preferredStyle: .actionSheet)
        }
        
        alert!.addAction(UIAlertAction(title: "10.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "10.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "20.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "20.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "30.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "30.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "50.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "50.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "100.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "100.000 VNĐ"
        }))
        
        alert?.addAction(UIAlertAction(title: "200.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "200.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "500.000 VNĐ", style: .default, handler: { (action) in
            self.lblMenhGia.text = "500.000 VNĐ"
        }))
        
        alert!.addAction(UIAlertAction(title: "Huỷ".localized, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alert!, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func selectCardType() {
        //let alert = UIAlertController(title: "Loai Thẻ", message: nil, preferredStyle: .actionSheet)
        var alert:UIAlertController? = nil
        if IS_IPAD{
            alert = UIAlertController(title: nil, message: "Loai Thẻ", preferredStyle: .alert)
        }else{
            alert = UIAlertController(title: nil, message: "Loai Thẻ", preferredStyle: .actionSheet)
        }
        
        alert!.addAction(UIAlertAction(title: "Viettel", style: .default, handler: { (action) in
            self.lblLoaiThe.text = "Viettel"
        }))
        
        alert!.addAction(UIAlertAction(title: "Vina Phone", style: .default, handler: { (action) in
            self.lblLoaiThe.text = "Vina Phone"
        }))
        
        alert!.addAction(UIAlertAction(title: "Huỷ".localized, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alert!, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func executeNapTheDienThoai(_ sender: Any) {
        guard isCheckField() else {
            return
        }
        self.presentConfirmAlertView(title: "Kiểm tra một lượt nhé", message: "Mã thẻ: \(txtMaTheCao.text!)\n Mã Seri: \(txtSoSeri.text!)\n Mệnh giá: \(lblMenhGia.text!)\n Loại thẻ: \(lblLoaiThe.text!)", okTitle: "Nạp thẻ", cancelTitle: "Nhập lại") { (isOK) in
            if isOK {
                self.napTheDienThoai()
            }
        }
    }
    
    private func napTheDienThoai() {
        let param: [String : Any] = ["mapin": txtMaTheCao.text!, "maseri": txtSoSeri.text!, "menhgiathe": lblMenhGia.text!.replacingOccurrences(of: " VNĐ", with: "").replacingOccurrences(of: ".", with: ""), "provinderCode": lblLoaiThe.text! == "Viettel" ? "VTT" : "VNP", "userid": Session.shared.userProfile.Id, "username": Session.shared.userProfile.UserName]
        self.showLoading()
        APIService.napTheDienThoai(param: param) { (response, message) in
            self.hideLoading()
            Toast.show(message ?? "Có lỗi xảy ra")
        }
    }
    
    private func isCheckField() -> Bool {
        if lblMenhGia.text == "Chọn mệnh giá" {
            Toast.showErr("Bạn chưa chọn mệnh giá")
            return false
        }
        if txtSoSeri.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập số Seri")
            return false
        }
        if txtMaTheCao.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập mã thẻ cào")
            return false
        }
        return true
    }
}
