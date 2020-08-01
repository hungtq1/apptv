//
//  TiemTapHoaViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/11/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TiemTapHoaViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var listDanDuoc = [DanDuoc]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.navigationItem.title = "TIỆM TẠP HOÁ"
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: TiemTapHoaCell.self)
        self.tableView.tableFooterView = UIView()
        self.showLoading()
        APIService.getListDanDuoc { (listDanDuoc, message) in
            self.hideLoading()
            if let listDanDuoc = listDanDuoc {
                self.listDanDuoc = listDanDuoc
                self.tableView.reloadData()
            }
        }
    }
    
    private func openChiTietTapHoa(danDuoc: DanDuoc) {
        let chitietTapHoa = ChiTietTapHoaViewController.instantiateViewControllerFromStoryboard(storyboardName: .tiemTapHoa)
        chitietTapHoa.danDuoc = danDuoc
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chitietTapHoa, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}

extension TiemTapHoaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDanDuoc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TiemTapHoaCell", for: indexPath) as! TiemTapHoaCell
        let danDuoc = self.listDanDuoc[indexPath.row]
        cell.imgIcon.sd_setImage(with: URL(string: danDuoc.HinhAnh)) { (image, error, cacheType, url) in
            
        }
        cell.lblName.text = danDuoc.TenPhapBao
        cell.lblGia.text = "Giá: \(danDuoc.Gia) Tiên Linh Thạch"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openChiTietTapHoa(danDuoc: listDanDuoc[indexPath.row])
    }
}
