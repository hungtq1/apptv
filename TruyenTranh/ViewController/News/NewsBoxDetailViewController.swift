//
//  NewsBoxDetailViewController.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import UIKit
import SVProgressHUD
import SVPullToRefresh
import SDWebImage
import ImageSlideshow
import WebKit

class NewsBoxDetailViewController: BaseViewController, UIScrollViewDelegate, WKUIDelegate {
    @IBOutlet weak var myWebView: WKWebView!
    var descTitle = ""
    var descNews = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết Đại Sảnh"
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupUI() {
        self.myWebView.scrollView.delegate = self
        self.myWebView.allowsLinkPreview = false
        self.myWebView.uiDelegate = self
        self.myWebView.scrollView.subviews.forEach { $0.isUserInteractionEnabled = false }
        let pageHtml = formatNewsHTML(title: descTitle, content: descNews)
        self.myWebView.loadHTMLString(pageHtml, baseURL: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.style.webkitUserSelect='none';")
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';")
        webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';")
        webView.evaluateJavaScript("document.body.setAttribute('ondragstart','return false')")
        webView.evaluateJavaScript("var elems = document.getElementsByTagName('a'); for (var i = 0; i < elems.length; i++) { elems[i]['href'] = 'javascript:(void)'; }")
    }
}
