//
//  EditProfileViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {
    @IBOutlet weak var txtDanhHieu: FWFloatingLabelTextField!
    @IBOutlet weak var txtEmail: FWFloatingLabelTextField!
    @IBOutlet weak var txtNgaySinh: FWFloatingLabelTextField!
    @IBOutlet weak var txtGioiTinh: FWFloatingLabelTextField!
    @IBOutlet weak var txtDiaChi: FWFloatingLabelTextField!
    @IBOutlet weak var txtSoThich: FWFloatingLabelTextField!
    @IBOutlet weak var txtMangXaHoi: FWFloatingLabelTextField!
    @IBOutlet weak var txtTinhCach: FWFloatingLabelTextField!
    @IBOutlet weak var txtSoTruong: FWFloatingLabelTextField!
    @IBOutlet weak var txtDiaDiemYeuThich: FWFloatingLabelTextField!
    @IBOutlet weak var txtMonAnYeuThich: FWFloatingLabelTextField!
    @IBOutlet weak var txtThanTuong: FWFloatingLabelTextField!
    @IBOutlet weak var txtBaiHatYeuThich: FWFloatingLabelTextField!
    @IBOutlet weak var txtMonTTYeuThich: FWFloatingLabelTextField!
    @IBOutlet weak var txtTuBachBanThan: FWFloatingLabelTextField!
    @IBOutlet weak var lblCungHoangDao: UILabel!
    @IBOutlet weak var lblNhomMau: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.getDetailUser()
    }
    
    private func setupUI() {
        self.title = "Thông tin cơ bản"
        let userProfile = Session.shared.userProfile
        txtGioiTinh.delegate = self
        txtDanhHieu.delegate = self
        txtEmail.delegate = self
        self.txtNgaySinh.setInputViewDatePicker(target: self, selector: #selector(tapDateIssueDone), maximumDate: Date(), minimumDate: nil)
        txtDanhHieu.text = userProfile.DanhHieu
        txtEmail.text = userProfile.Email
        txtNgaySinh.text = userProfile.BirthDay
        txtGioiTinh.text = userProfile.Gender
        txtDiaChi.text = userProfile.Address
        txtSoThich.text = userProfile.thongTinCaNhan.SoThich
        txtMangXaHoi.text = userProfile.thongTinCaNhan.TrangMXH
        txtTinhCach.text = userProfile.thongTinCaNhan.TinhCach
        txtDiaDiemYeuThich.text = userProfile.thongTinCaNhan.DiaDiemYeuThich
        txtMonAnYeuThich.text = userProfile.thongTinCaNhan.MonAnYeuThich
        txtThanTuong.text = userProfile.thongTinCaNhan.ThanTuong
        txtBaiHatYeuThich.text = userProfile.thongTinCaNhan.NhacYeuThich
        txtMonAnYeuThich.text = userProfile.thongTinCaNhan.MonTheThaoYeuThich
        txtTuBachBanThan.text = userProfile.thongTinCaNhan.MoTa
        lblCungHoangDao.text = userProfile.thongTinCaNhan.CungHoangDao
        lblNhomMau.text = userProfile.thongTinCaNhan.NhomMau
    }
    
    @IBAction func updateBaseInfor(_ sender: Any) {
        guard isCheckfiledBaseInfor() else {
            return
        }
        let param = ["userid": Session.shared.userLogin.user.ID,
                     "danhhieu": txtDanhHieu.text!,
                     "ngaysinh": txtNgaySinh.text!,
                     "gioitinh":txtGioiTinh.text!,
                     "diachi":txtDiaChi.text!,
                     "email":txtEmail.text!]
        self.showLoading()
        APIService.updateUserProfile(param: param) { (userProfile, message) in
            self.hideLoading()
            if let userProfile = userProfile {
                Toast.showSuccess("Cập nhật thông tin cá nhân thành công")
                self.getDetailUser()
            } else {
                Toast.showErr(message ?? "Có lỗi xảy ra")
            }
        }
    }
    
    @IBAction func updatePersonalInfor(_ sender: Any) {
        let param = ["userid": Session.shared.userLogin.user.ID,
                     "cunghoangdao": lblCungHoangDao.text!,
                     "nhommau": lblNhomMau.text!.replacingOccurrences(of: "Nhóm Máu ", with: ""),
                     "sothich":txtSoThich.text!,
                     "trangmangxahoi":txtMangXaHoi.text!,
                     "tinhcach":txtTinhCach.text!,
                     "kynang": txtSoTruong.text!,
                     "diadiemyeuthich": txtDiaDiemYeuThich.text!,
                     "monanyeuthich": txtMonAnYeuThich.text!,
                     "thantuong":txtThanTuong.text!,
                     "baihatyeuthich":txtBaiHatYeuThich.text!,
                     "monthethaoyeuthich":txtMonAnYeuThich.text!,
                     "tubachbanthan": txtTuBachBanThan.text!]
        self.showLoading()
        APIService.updateProfileAdvance(param: param) { (userProfile, message) in
            self.hideLoading()
            if userProfile != nil {
                Toast.showSuccess("Cập nhật thông tin cá nhân thành công")
                self.getDetailUser()
            } else {
                Toast.showErr(message ?? "Có lỗi xảy ra")
            }
        }
    }
    
    private func getDetailUser() {
        self.showLoading()
        APIService.getDetailUser(userid: Session.shared.userLogin.user.ID) { (userProfile, message) in
            self.hideLoading()
            if let userProfile = userProfile {
                Session.shared.userProfile = userProfile
                self.setupUI()
            }
        }
    }
    
    private func isCheckfiledBaseInfor() -> Bool {
        if txtDanhHieu.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập danh hiệu")
            return false
        }
        
        if txtEmail.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập email")
            return false
        }
        
        if txtNgaySinh.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập ngày sinh")
            return false
        }
        
        if txtGioiTinh.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập giới tính")
            return false
        }
        
        if txtDiaChi.text!.isEmpty {
            Toast.showErr("Bạn chưa nhập địa chỉ")
            return false
        }
        
        return true
    }
    
    private func isCheckfiledPersonalInfor() -> Bool {
        return true
    }
    
    private func selectGender() {
        var alertController:UIAlertController? = nil
        if IS_IPAD{
            alertController = UIAlertController(title: nil, message: "Chọn giới tính", preferredStyle: .alert)
        }else{
            alertController = UIAlertController(title: nil, message: "Chọn giới tính", preferredStyle: .actionSheet)
        }
        
        alertController!.addAction(UIAlertAction(title: "Nam", style: .default, handler: { (action) in
            self.txtGioiTinh.text = "Nam"
        }))
        
        alertController!.addAction(UIAlertAction(title: "Nữ", style: .default, handler: { (action) in
            self.txtGioiTinh.text = "Nữ"
        }))
        
        alertController!.addAction(UIAlertAction(title: "Huỷ".localized, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        self.present(alertController!, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc func tapDateIssueDone() {
        if let datePicker = self.txtNgaySinh.inputView as? UIDatePicker {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.ddMMYYYY.rawValue
            self.txtNgaySinh.text = formatter.string(from: datePicker.date)
        }
        self.txtNgaySinh.resignFirstResponder()
    }
    
    @IBAction func openPopupCungHoangDao(_ sender: Any) {
        let profilePopup = ProfilePopupViewController.instantiateViewControllerFromStoryboard(storyboardName: .popup)
        profilePopup.modalPresentationStyle = .overCurrentContext
        profilePopup.titleStr = "Cung Hoàng Đạo"
        profilePopup.listItem = ["Bạch Dương", "Kim Ngưu", "Song Tử", "Cự Giải", "Sư Tử", "Xử Nữ", "Thiên Bình", "Thiên Yết", "Nhân Mã", "Ma Kết", "Bảo Bình", "Song Ngư"]
        profilePopup.selectItemBlock = { item in
            self.lblCungHoangDao.text = item
        }
        self.present(profilePopup, animated: true, completion: nil)
    }
    
    @IBAction func openPopupNhomMau(_ sender: Any) {
        let profilePopup = ProfilePopupViewController.instantiateViewControllerFromStoryboard(storyboardName: .popup)
        profilePopup.modalPresentationStyle = .overCurrentContext
        profilePopup.titleStr = "Nhóm Máu"
        profilePopup.listItem = ["Nhóm Máu A", "Nhóm Máu B", "Nhóm Máu AB", "Nhóm Máu O"]
        profilePopup.selectItemBlock = { item in
            self.lblNhomMau.text = item
        }
        self.present(profilePopup, animated: true, completion: nil)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtGioiTinh:
            self.txtGioiTinh.resignFirstResponder()
            self.selectGender()
        default:
            break
        }
    }
}
