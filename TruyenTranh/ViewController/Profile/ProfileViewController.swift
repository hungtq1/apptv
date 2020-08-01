//
//  ProfileViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDangCap: UILabel!
    @IBOutlet weak var lblDanhHieu: UILabel!
    @IBOutlet weak var lblCongHien: UILabel!
    @IBOutlet weak var lblBangPhai: UILabel!
    @IBOutlet weak var lblTuLuyen: UILabel!
    @IBOutlet weak var sliderKinhNghiem: UISlider!
    @IBOutlet weak var lblLinhThach: UILabel!
    @IBOutlet weak var lblDateVip: UILabel!
    
    var userProfile = UserProfile()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thông tin thành viên"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "user_bg.png")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    private func setupUI() {
        userProfile = Session.shared.userProfile
        imgAvatar.sd_setImage(with: URL(string: userProfile.Avatar)) { (image, error, cacheType, url) in
            
        }
        lblUsername.text = userProfile.UserName
        lblDangCap.text = "Đẳng Cấp: \(userProfile.Dangcap.DangCapName)"
        lblDanhHieu.text = "Danh Hiệu: \(userProfile.DanhHieu)"
        lblCongHien.text = "Cống Hiến: \(userProfile.CongHien) bài đăng"
        lblBangPhai.text = "Bang Phái: \(userProfile.NhomDich)"
        lblLinhThach.text = "Tiên Linh Thạch: \(userProfile.NumberKNB)"
        lblTuLuyen.text = "Tình Trạng Luyện Tập: \(userProfile.KinhNghiem)/\(userProfile.Dangcap.TriKinhNghiem)"
        lblDateVip.text = userProfile.UserType == 1 ? "Thành Viên VIP(Ngày hết hạn): \(userProfile.DateVip.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSZ.rawValue)?.toString(format: DateFormat.dd_MM_YYYY) ?? "")" : ""
        sliderKinhNghiem.value = Float(userProfile.KinhNghiem) / Float(userProfile.Dangcap.TriKinhNghiem)
    }

    @IBAction func openChangeAvatar(_ sender: Any) {
        self.openLibararies()
    }
    
    @IBAction func openChangePassword(_ sender: Any) {
        let editProfileVC = ChangePasswordViewController.instantiateViewControllerFromStoryboard(storyboardName: .profile)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func openChangeProfile(_ sender: Any) {
        let editProfileVC = EditProfileViewController.instantiateViewControllerFromStoryboard(storyboardName: .profile)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    private func openLibararies() {
        var alert:UIAlertController? = nil
        if IS_IPAD{
            alert = UIAlertController(title: nil, message: "Choose_photo_from".localized, preferredStyle: .alert)
        }else{
            alert = UIAlertController(title: nil, message: "Choose_photo_from".localized, preferredStyle: .actionSheet)
        }
        
        alert!.addAction(UIAlertAction(title: "Photo Library".localized, style: .default , handler:{ (UIAlertAction)in
            self.openMedia(type: .photoLibrary)
        }))
        
        alert!.addAction(UIAlertAction(title: "Camera".localized, style: .default , handler:{ (UIAlertAction)in
            self.openMedia(type: .camera)
        }))
        
        alert!.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert!, animated: true, completion: {
            print("completion block")
        })
    }
    
    private func openMedia(type: UIImagePickerController.SourceType) {
        let vc = UIImagePickerController()
        vc.sourceType = type
        vc.videoQuality = .typeMedium
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imgAvatar.image = image
            self.showLoading()
            APIService.uploadAvatar(client_secret: userProfile.UserName, client_id: userProfile.Id, image: image.pngData()!) { (isSuccess, message) in
                self.hideLoading()
                if isSuccess {
                    Session.shared.userProfile.Avatar = message ?? ""
                    Toast.show((isSuccess ? "Cập nhật avatar thành công" : message) ?? "Có lỗi xảy ra")
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
