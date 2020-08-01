//
//  TuiCanKhonViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/6/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TuiCanKhonViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSoLinhThach: UILabel!
    var listPhapBao = [PhapBao]()
    var userProfile = UserProfile()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.getListPhapBaoUser()
    }
    

    private func setupUI() {
        self.title = "Túi Càn Khôn"
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: TuiCanKhonCell.self)
    }

    private func getListPhapBaoUser() {
        self.showLoading()
        APIService.getListPhapBaoUser(userid: Session.shared.userProfile.Id) { (response, message) in
            self.hideLoading()
            if let phapBao = response?.phapBao {
                self.listPhapBao = phapBao
                self.tableView.reloadData()
            }
            if let userProfile = response?.thanhVien {
                self.lblSoLinhThach.text = "BẠN ĐANG CÓ \(userProfile.LinhThach) VIÊN LINH THẠCH"
            }
            
            if let message = message {
                Toast.showErr(message)
            }
        }
    }
    
    private func suDungPhapBaoUser(phapBao: PhapBao) {
        let param = ["VPID" : phapBao.Id]
        self.showLoading()
        APIService.suDungPhapBaoUser(param: param) { (response, message) in
            self.hideLoading()
            Toast.show(message ?? "Có lỗi xảy ra!")
        }
    }
}

extension TuiCanKhonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhapBao.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TuiCanKhonCell", for: indexPath) as! TuiCanKhonCell
        let phapBao = self.listPhapBao[indexPath.row]
        cell.indexPath = indexPath
        cell.configCell(phapBao: phapBao)
        cell.executeUse = { indexPath in
            self.suDungPhapBaoUser(phapBao: self.listPhapBao[indexPath.row])
        }
        return cell
    }
}
