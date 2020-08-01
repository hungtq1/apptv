//
//  ChiTietTapHoaViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/13/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ChiTietTapHoaViewController: BaseViewController {
    @IBOutlet weak var lblTenPhapBao: UILabel!
    @IBOutlet weak var lblGiaPhapBao: UILabel!
    @IBOutlet weak var lblDangCapYeuCau: UILabel!
    @IBOutlet weak var imgPhapBao: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var danDuoc = DanDuoc()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = danDuoc.TenPhapBao
        lblTenPhapBao.text = danDuoc.TenPhapBao
        lblGiaPhapBao.text = "Giá: \(danDuoc.Gia) Tiên linh thạch"
        lblDangCapYeuCau.text = "Đẳng Cấp Yêu Cầu: \(danDuoc.DangCapYeuCau.DangCapName)"
        lblDescription.text = danDuoc.MoTa
        imgPhapBao.sd_setImage(with: URL(string: danDuoc.HinhAnh)) { (image, error, cacheType, url) in
            
        }
    }
    
    @IBAction func executeMuaDanDuoc(_ sender: Any) {
        let param = ["phapbaoid": danDuoc.Id, "userid": Session.shared.userProfile.Id]
        self.showLoading()
        APIService.muaPhapBao(param: param) { (danDuoc, message) in
            self.hideLoading()
            if let message = message {
                Toast.show(message)
            }
        }
    }
    
}
