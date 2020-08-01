//
//  MoreViewController.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import Material
import FontAwesomeKit

enum ListMenu: String {
    case userMemberVip = "Thành viên Vip"
    case dateExpired = "Ngày hết hạn "
    case userGuide = "Hướng dẫn sử dụng App"
    case login = "Đăng nhập"
    case register = "Đăng ký"
    case editProfile = "Chỉnh sửa thông tin"
    case notification = "Thông báo"
    case napTienLinhThach = "Nạp Tiên Linh Thạch"
    case lichSuNapTienLinhThach = "Lịch Sử Nạp Tiên Linh Thạch"
    case danhSachGiaoDich = "Danh Sách Giao Dịch"
    case tuiCanKhon = "Túi Càn Khôn"
    case userProfile = "Trang cá nhân"
    case logout = "Đăng xuất"
    case home = "Trang chủ"
    case cart = "Tiệm tạp hoá"
    case versionApp = "Phiên bản: "
}
class MoreViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDangCap: UILabel!
    @IBOutlet weak var imgDangCap: UIImageView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblLinhThach: UILabel!
    
    var userGuide = [ListMenu.userMemberVip.rawValue, ListMenu.dateExpired.rawValue, ListMenu.userGuide.rawValue]
    let menuMember = [ListMenu.login.rawValue, ListMenu.register.rawValue]
    let menuMemberLogged = [ListMenu.editProfile.rawValue, ListMenu.notification.rawValue, ListMenu.napTienLinhThach.rawValue, ListMenu.lichSuNapTienLinhThach.rawValue , ListMenu.danhSachGiaoDich.rawValue, ListMenu.tuiCanKhon.rawValue ,ListMenu.logout.rawValue]
    let funcApp = [ListMenu.home.rawValue, ListMenu.cart.rawValue, ListMenu.versionApp.rawValue]
    let funcAppActive = [ListMenu.home.rawValue, ListMenu.versionApp.rawValue]
    var isLogged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: headerSectionMoreCell.self)
        self.tableView.tableFooterView = UIView()
        self.tableView.addPullToRefresh {
            self.getDetailUser()
        }
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillAppear(_:)), name: .ReloadThanhVien, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        isLogged = !(UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? "").isEmpty
        if isLogged {
            self.getDetailUser()
        } else {
            imgCoin.isHidden = true
            lblLinhThach.text = ""
            self.lblUsername.text = "Khách"
            self.lblDangCap.text = "Phàm nhân"
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func setupUI() {
        imgDangCap.image = FAKIonIcons.trophyIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))?.maskWithColor(color: UIColor.white)
        
    }
    
    @objc func getDetailUser() {
        self.tableView.pullToRefreshView.stopAnimating()
        self.showLoading()
        let userID = UserDefaults.standard.string(forKey: Constants.USER_ID) ?? ""
        APIService.getDetailUser(userid: userID) { (userProfile, message) in
            self.hideLoading()
            if let userProfile = userProfile {
                Session.shared.userProfile = userProfile
                self.getProfileSuccess(userProfile: userProfile)
            }
        }
    }
        
    private func getProfileSuccess(userProfile: UserProfile) {
        imgCoin.isHidden = false
        imgCoin.image = UIImage(named: "diamond-20")
        imgAvatar.sd_setImage(with: URL(string: userProfile.Avatar)) { (image, error, cacheType, url) in
            if let image = image {
                self.imgAvatar.image = image
            } else {
                self.imgAvatar.image = UIImage(named: "user")
            }
        }
        lblLinhThach.text = "\(userProfile.NumberKNB)"
        lblUsername.text = userProfile.UserName
        lblDangCap.text = userProfile.Dangcap.DangCapName
        self.tableView.reloadData()
    }
    
    private func openUserGuide() {
        let userGuideVC = UserGuideViewController.instantiateViewControllerFromStoryboard(storyboardName: .more)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(userGuideVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openUserProfile() {
        let profileVC = ProfileViewController.instantiateViewControllerFromStoryboard(storyboardName: .profile)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(profileVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openLogin() {
        let loginVC = LoginViewController.instantiateViewControllerFromStoryboard(storyboardName: .login)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openRegister() {
        let registerVC = SignupViewController.instantiateViewControllerFromStoryboard(storyboardName: .signup)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(registerVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openNapTienLinhThach() {
        let napTienVC = NapTienLienThachViewController.instantiateViewControllerFromStoryboard(storyboardName: .more)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(napTienVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openTiemTapHoa() {
        let tiemTapHoaVC = TiemTapHoaViewController.instantiateViewControllerFromStoryboard(storyboardName: .tiemTapHoa)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(tiemTapHoaVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openNotification() {
        let notificationVC = NotificationsViewController.instantiateViewControllerFromStoryboard(storyboardName: .notification)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(notificationVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openUserInfor() {
        let userInforVC = UserInforViewController.instantiateViewControllerFromStoryboard(storyboardName: .profile)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(userInforVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openLichSuNapLinhThach() {
        let historyLinhThach = LichSuNapTienLinhThachVC.instantiateViewControllerFromStoryboard(storyboardName: .history)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(historyLinhThach, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openDanhSachGiaoDich() {
        let danhSachVC = DanhSachGiaoDichVC.instantiateViewControllerFromStoryboard(storyboardName: .history)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(danhSachVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func openTuiCanKhon() {
        let tuiCanKhon = TuiCanKhonViewController.instantiateViewControllerFromStoryboard(storyboardName: .tiemTapHoa)
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(tuiCanKhon, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func logOut() {
        self.showLoading()
        APIService.doLogout { (response, message) in
            self.hideLoading()
            Session.shared.listTheoDoi.removeAll()
            Toast.showSuccess(message ?? "Xảy ra lỗi")
            self.appDelegate.unSubscribeTopic(topic: "tsh_user_" + Session.shared.userProfile.Id)
            UserDefaults.standard.removeObject(forKey: Constants.TOKEN_KEY)
            UserDefaults.standard.removeObject(forKey: Constants.USERNAME)
            UserDefaults.standard.removeObject(forKey: Constants.PASSWORD)
            UserDefaults.standard.removeObject(forKey: Constants.USER_ID)
            Session.shared.userProfile = UserProfile()
            UserDefaults.standard.synchronize()
            self.imgCoin.isHidden = true
            self.lblLinhThach.text = ""
            self.lblUsername.text = "Khách"
            self.lblDangCap.text = "Phàm nhân"
            self.imgAvatar.image = UIImage(named: "user")
            self.imgDangCap.image = FAKIonIcons.trophyIcon(withSize: 16)?.image(with: CGSize(width: 16, height: 16))?.maskWithColor(color: UIColor.white)
            self.isLogged = !(UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? "").isEmpty
            self.tableView.reloadData()
        }
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if self.isLogged{
                if Session.shared.userLogin.user.UserType == 1{
                    return userGuide.count
                }else{
                    return 1
                }
            }else{
                return 1
            }
        case 1:
            return isLogged ? menuMemberLogged.count : menuMember.count
        default:
            return Session.shared.userProfile.Active == 0 ? funcAppActive.count : funcApp.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            if self.isLogged{
                if Session.shared.userProfile.UserType == 1{
                    if indexPath.row == 0{
                        cell.textLabel?.text = userGuide[indexPath.row]
                        cell.textLabel?.textColor = UIColor(red: 0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0)
                        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
                    }else if indexPath.row == 1{
                        let dateVipStr = Session.shared.userProfile.DateVip
                        cell.textLabel?.text = userGuide[indexPath.row] + (dateVipStr.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSZ.rawValue)?.toString(format: DateFormat.dd_MM_YYYY))!
                    }else{
                        cell.textLabel?.text = userGuide[indexPath.row]
                        cell.imageView?.image = FAKFontAwesome.githubIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
                    }
                }else {
                    cell.textLabel?.text = userGuide[2]
                    cell.imageView?.image = FAKFontAwesome.githubIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
                }
            }else{
                cell.textLabel?.text = userGuide[2]
                cell.imageView?.image = FAKFontAwesome.githubIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
            }
        case 1:
            cell.textLabel?.text = isLogged ? menuMemberLogged[indexPath.row] : menuMember[indexPath.row]
            cell.imageView?.image = iconCellItem(type: isLogged ? menuMemberLogged[indexPath.row] : menuMember[indexPath.row])
        default:
            if funcApp[indexPath.row] == ListMenu.versionApp.rawValue {
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                    cell.textLabel?.text = funcApp[indexPath.row] + version
                }
            } else {
                cell.textLabel?.text = Session.shared.userProfile.Active == 0 ? funcAppActive[indexPath.row] : funcApp[indexPath.row]
            }
            cell.imageView?.image = iconCellItem(type: Session.shared.userProfile.Active == 0 ? funcAppActive[indexPath.row] : funcApp[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func iconCellItem(type: String) -> UIImage? {
        switch type {
        case ListMenu.editProfile.rawValue:
            return FAKFontAwesome.userCircleIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.notification.rawValue:
            return FAKMaterialIcons.notificationsIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.userProfile.rawValue:
            return FAKIonIcons.iosBodyIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.login.rawValue:
            return FAKIonIcons.logInIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.register.rawValue:
            return FAKIonIcons.iosBodyIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.home.rawValue:
            return FAKIonIcons.iosHomeIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.cart.rawValue:
            return FAKIonIcons.iosCartIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.napTienLinhThach.rawValue:
            return FAKFontAwesome.dollarIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.lichSuNapTienLinhThach.rawValue:
            return FAKIonIcons.cashIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.danhSachGiaoDich.rawValue:
            return FAKFontAwesome.historyIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        case ListMenu.tuiCanKhon.rawValue:
            return FAKIonIcons.bagIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))?.maskWithColor(color: .red)
        default:
            return FAKIonIcons.logOutIcon(withSize: 20)?.image(with: CGSize(width: 20, height: 20))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if self.isLogged{
                if Session.shared.userLogin.user.UserType == 1{
                    if indexPath.row == 2{
                        openUserGuide()
                    }
                }else{
                    openUserGuide()
                }
            }else{
                openUserGuide()
            }
        case 1:
            switch isLogged ? menuMemberLogged[indexPath.row] : menuMember[indexPath.row] {
            case ListMenu.editProfile.rawValue:
                openUserProfile()
            case ListMenu.login.rawValue:
                openLogin()
            case ListMenu.register.rawValue:
                openRegister()
            case ListMenu.napTienLinhThach.rawValue:
                openNapTienLinhThach()
            case ListMenu.logout.rawValue:
                self.logOut()
            case ListMenu.notification.rawValue:
                openNotification()
            case ListMenu.userProfile.rawValue:
                openUserInfor()
            case ListMenu.lichSuNapTienLinhThach.rawValue:
                openLichSuNapLinhThach()
            case ListMenu.danhSachGiaoDich.rawValue:
                openDanhSachGiaoDich()
            case ListMenu.tuiCanKhon.rawValue:
                openTuiCanKhon()
            default:
                print("Nothing to do")
            }
        default:
            switch funcApp[indexPath.row] {
            case ListMenu.home.rawValue:
                self.tabBarController?.selectedIndex = 1
            case ListMenu.cart.rawValue:
                self.openTiemTapHoa()
            default:
                print("Nothing to do")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerSectionMoreCell") as! headerSectionMoreCell
        if section == 0 {
            return nil
        } else {
            if section == 1 {
                header.imageView?.image = FAKFontAwesome.userCircleIcon(withSize: 40)?.image(with: CGSize(width: 40, height: 40))?.maskWithColor(color: .white)
                header.lblTitleHeader.text = "Chức năng thành viên"
            }
            if section == 2 {
                if #available(iOS 13.0, *) {
                    header.imageView?.image = FAKIonIcons.iosHeartIcon(withSize: 40)?.image(with: CGSize(width: 40, height: 40))?.maskWithColor(color: .white)
                } else {
                    // Fallback on earlier versions
                }
                header.lblTitleHeader.text = "Truyện siêu hay"
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 45.0
        }
    }
}
