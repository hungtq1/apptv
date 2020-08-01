//
//  BankAndWalletViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/8/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import WebKit

class BankAndWalletViewController: BaseViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    
    private func setupUI() {
        self.title = "NẠP TIÊN LINH THẠCH"
        let url = "https://m.truyensieuhay.com/phuongthucnapkhac.html"
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
    @IBAction func actionCopy(_ sender: UIButton) {
        Toast.showSuccess("Đã sao chép")
        switch sender.tag {
        case 0:
            UIPasteboard.general.string = ""
        case 1:
            UIPasteboard.general.string = ""
        default:
            UIPasteboard.general.string = ""
        }
    }
}
