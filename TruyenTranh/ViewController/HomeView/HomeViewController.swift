//
//  HomeViewController.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import SVProgressHUD
import SVPullToRefresh
import SDWebImage
import ImageSlideshow

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDownloadVip: UIButton!
    var news:[News]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_menu"), style: .plain, target: self, action: #selector(tapLinkStory))
        self.setupUI()
        self.getListBoxForum()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI() {
        self.navigationItem.title = "Đại Sảnh"
        self.btnDownloadVip.cornerRadius = 10.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func getListBoxForum(){
        let progress = self.showProgress()
        self.news = [News]()
        APIService.getListBoxForum() { (data, message) in
            if let data = data {
                self.hideProgress(progress)
                self.news = data
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  Tin tức"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        let frame = CGRect(x: 0, y: 8, width: 24, height: 24)
        let myCustomView = UIImageView(frame: frame)
        myCustomView.image = (FAKFontAwesome.globeIcon(withSize: 24)?.image(with: CGSize(width: 24, height: 24)).maskWithColor(color: .white))
        header.addSubview(myCustomView)
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = UIColor(red: 46/255, green: 136/255, blue: 204/255, alpha: 1.0)
        header.textLabel?.textAlignment = NSTextAlignment.left
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let newObj = self.news![indexPath.row]
        if indexPath.row == 0{
            cell.textLabel?.text = newObj.BoxName
            cell.imageView?.image = FAKFontAwesome.bookmarkOIcon(withSize: 24)?.image(with: CGSize(width: 24, height: 24))
        }else{
            cell.textLabel?.text = newObj.BoxName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsObj = self.news![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultFilterVC = storyboard.instantiateViewController(withIdentifier: "NewsBoxVC") as! NewsBoxViewController
        resultFilterVC.boxID = newsObj.Id
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(resultFilterVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func btnDownloadStoryVIP(_ sender: Any) {
        guard let url = URL(string: Constants.linkStory) else {
            return //be safe
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
