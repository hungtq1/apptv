//
//  TuluyenViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TuluyenViewController: BaseViewController, BannerViewControllerDelegate {
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
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var btnStartTL: UIButton!
    
    var userProfile = UserProfile()
    var adUnitID:String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phòng Tu Luyện"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "user_bg.png")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isLogged = !(UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? "").isEmpty
        if isLogged {
            self.myView.isHidden = false
            self.imgAvatar.isHidden = false
            self.btnStartTL.isHidden = false
            self.setupUI()
            self.getAdUnitID()
        }else{
            self.myView.isHidden = true
            self.imgAvatar.isHidden = true
            self.btnStartTL.isHidden = true
            Toast.show("Bạn cần đăng nhập để bắt đầu tu luyện. Xin cảm ơn!")
        }
    }
    
    func finishAds() {
        self.showLoading()
        APIService.tuLuyen(uid:Session.shared.userLogin.user.ID) { (data, message) in
            self.hideLoading()
            if let message = message {
                let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Thoát", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
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

    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    @IBAction func startTuluyen(_ sender: Any) {
        let isLogged = !(UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? "").isEmpty
        if isLogged {
            let storyboard = UIStoryboard(name: "BookStore", bundle: nil)
            let bannerVC = storyboard.instantiateViewController(withIdentifier: "BannerVC") as! BannerViewController
            bannerVC.adUnitID = self.adUnitID
            bannerVC.delegate = self
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(bannerVC, animated: true)
            self.hidesBottomBarWhenPushed = false
        }else{
            UIViewController().topController().presentConfirmAlertView(title: "Thông báo", message: "Chức năng này yêu cầu bạn phải đăng nhập để thực hiện, vui lòng đăng nhập trước để thực hiện chức năng này", okTitle: "Đăng nhập/Đăng ký", cancelTitle: "Huỷ") { (isOk) in
                if isOk {
                    self.openLoginVC()
                }
            }
        }
    }
    
    public func openLoginVC() {
        let loginVC = LoginViewController.instantiateViewControllerFromStoryboard(storyboardName: .login)
        UIViewController().topController().navigationController?.pushViewController(loginVC, animated: true)
    }

    func getAdUnitID() {
        self.showLoading()
        APIService.getAdUnitID() { (data, message) in
            self.hideLoading()
            if let data = data {
                if let admod = data.admod{
                    self.adUnitID = admod
                }else{
                    self.adUnitID = ""
                }
            }else{
                Toast.showErr("Có lỗi xảy ra!")
            }
        }
    }
}
