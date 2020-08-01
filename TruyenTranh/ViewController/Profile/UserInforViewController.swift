//
//  UserInforViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class UserInforViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDangCap: UILabel!
    @IBOutlet weak var lblDanhHieu: UILabel!
    @IBOutlet weak var lblCongHien: UILabel!
    @IBOutlet weak var lblBangPhai: UILabel!
    @IBOutlet weak var lblTuLuyen: UILabel!
    @IBOutlet weak var sliderKinhNghiem: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Tường nhà"
        self.tableView.set(delegateAndDataSource: self)
        let userProfile = Session.shared.userProfile
        imgAvatar.sd_setImage(with: URL(string: userProfile.Avatar)) { (image, error, cacheType, url) in
            
        }
        lblUsername.text = userProfile.UserName
        lblDangCap.text = "Đẳng Cấp: \(userProfile.Dangcap.DangCapName)"
        lblDanhHieu.text = "Danh Hiệu: \(userProfile.DanhHieu)"
        lblCongHien.text = "Cống Hiến: \(userProfile.CongHien) bài đăng"
        lblBangPhai.text = "Bang Phái: \(userProfile.NhomDich)"
        lblTuLuyen.text = "Tình Trạng Luyện Tập: \(userProfile.KinhNghiem)/100"
        sliderKinhNghiem.value = Float(userProfile.KinhNghiem / userProfile.Dangcap.TriKinhNghiem)
    }
    
    @IBAction func selectInforType(_ sender: Any) {
    }
}

extension UserInforViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}
