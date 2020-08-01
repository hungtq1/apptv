//
//  DanhSachGiaoDichVC.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/6/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class DanhSachGiaoDichVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var listChapterBuy = [ChapterBuy]()
    var ipage = 1
    var isLoadmore = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.listChapterBuyedByUser()
    }
    
    private func setupUI() {
        self.title = "Chương đã mua"
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: DanhSachGiaoDichCell.self)
        self.tableView.addInfiniteScrolling { [weak self] in
            self?.isLoadmore = true
            self?.ipage += 1
            self?.listChapterBuyedByUser()
        }
        self.tableView.addPullToRefresh { [weak self] in
            self?.isLoadmore = false
            self?.ipage = 1
            self?.listChapterBuyedByUser()
        }
    }
    
    private func listChapterBuyedByUser() {
        let param:[String: Any] = ["userid": Session.shared.userProfile.Id, "ipage": 1, "ipagesize": 10]
        self.showLoading()
        self.tableView.infiniteScrollingView.stopAnimating()
        self.tableView.pullToRefreshView.stopAnimating()
        APIService.listChapterBuyedByUser(param: param) { (response, message) in
            self.hideLoading()
            if let listChapterBuy = response?.chapterBuy, listChapterBuy.count > 0 {
                if self.isLoadmore {
                    self.listChapterBuy.append(contentsOf: listChapterBuy)
                } else {
                    self.listChapterBuy = listChapterBuy
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension DanhSachGiaoDichVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listChapterBuy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DanhSachGiaoDichCell", for: indexPath) as! DanhSachGiaoDichCell
        let chapterBuy = listChapterBuy[indexPath.row]
        cell.configCell(chapterBuy: chapterBuy)
        return cell
    }
}
