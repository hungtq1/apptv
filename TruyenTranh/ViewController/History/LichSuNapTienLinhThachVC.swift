//
//  LichSuNapTienLinhThachVC.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/6/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import SVPullToRefresh

class LichSuNapTienLinhThachVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var listTransLinhThach = [HistoryLinhThach]()
    var ipage = 1
    var isLoadmore = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.getListLichSuNapLinhThach()
    }

    private func setupUI() {
        self.title = "Lịch Sử Nạp Tiên Linh Thạch"
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: LichSuLinhThachCell.self)
        self.tableView.addInfiniteScrolling { [weak self] in
            self?.isLoadmore = true
            self?.ipage += 1
            self?.getListLichSuNapLinhThach()
        }
        self.tableView.addPullToRefresh { [weak self] in
            self?.isLoadmore = false
            self?.ipage = 1
            self?.getListLichSuNapLinhThach()
        }
    }
    
    private func getListLichSuNapLinhThach() {
        let param:[String: Any] = ["userid": Session.shared.userProfile.Id, "ipage": ipage, "ipagesize": 10]
        self.showLoading()
        APIService.getHistoryTransaction(param: param) { (response, message) in
            self.hideLoading()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.pullToRefreshView.stopAnimating()
            if let listLinhThach = response?.historyLinhThach, listLinhThach.count > 0 {
                if self.isLoadmore {
                    self.listTransLinhThach.append(contentsOf: listLinhThach)
                } else {
                    self.listTransLinhThach = listLinhThach
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension LichSuNapTienLinhThachVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTransLinhThach.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LichSuLinhThachCell", for: indexPath) as! LichSuLinhThachCell
        let trans = listTransLinhThach[indexPath.row]
        cell.configCell(trans: trans)
        return cell
    }
}
