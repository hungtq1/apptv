//
//  NotificationsViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/15/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import SVPullToRefresh

class NotificationsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var listNotification = [NotificationModel]()
    var ipage = 1
    var isLoadMore = false
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Thông Báo Thành Viên"
        self.tableView.set(delegateAndDataSource: self)
        self.tableView.registerNibCellFor(type: NotificationCell.self)
        self.tableView.tableFooterView = UIView()
        self.tableView.addInfiniteScrolling {
            self.isLoadMore = true
            self.ipage += 1
            self.getListNotification()
        }
        
        self.tableView.addPullToRefresh {
            self.isLoadMore = false
            self.ipage = 1
            self.getListNotification()
        }
        
        self.getListNotification()
    }
    
    private func getListNotification() {
        self.showLoading()
        APIService.getListNotification(ipage: ipage, ipagesize: Constants.PAGE_SIZE, userid: Session.shared.userProfile.Id) { (listNotification, message) in
            self.hideLoading()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.pullToRefreshView.stopAnimating()
            if let listNotification = listNotification {
                if self.isLoadMore {
                    self.listNotification.append(contentsOf: listNotification)
                } else {
                    self.listNotification = listNotification
                }
                self.tableView.reloadData()
            } else {
                Toast.showErr(message ?? "Có xảy ra lỗi")
            }
        }
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notifi = self.listNotification[indexPath.row]
        cell.lblContentNotifi.attributedText = notifi.ContentNotifyCation.convertHtmlToAttributedStringWithCSS(font: .systemFont(ofSize: 16), csscolor: "#656565", lineheight: 5, csstextalign: "left")
        cell.lblTime.attributedText = "gửi lúc \((notifi.DateCreate.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSZ.rawValue)?.toString(format: DateFormat.hhmmaddMMYYYY))!)".convertHtmlToAttributedStringWithCSS(font: .systemFont(ofSize: 16), csscolor: "#656565", lineheight: 5, csstextalign: "left")
        return cell
    }
}
