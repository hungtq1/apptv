//
//  UserGuideViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import WebKit

class UserGuideViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Hướng dẫn đọc truyện"
        let url = "https://m.truyensieuhay.com/huongdandoctruyen.html"
        webView.load(URLRequest(url: URL(string: url)!))
    }
}
