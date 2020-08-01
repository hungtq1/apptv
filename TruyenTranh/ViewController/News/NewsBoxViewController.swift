//
//  NewsBoxViewController.swift
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

class NewsBoxViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let callApiGroup = DispatchGroup()
    var listNews: [ListNews]? = nil
    var uriimage:String? = nil
    private var pageNumber: Int = 1
    var boxID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Danh sách Đại Sảnh"
        self.listNews = [ListNews]()
        self.setupUI()
        self.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupUI() {
        self.collectionView.set(delegateAndDataSource: self)
        // register collection cell
        self.collectionView.registerNibCellFor(type: HomeViewCell.self)
        // set data source
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.addInfiniteScrolling {
            self.pageNumber = self.pageNumber + 1
            let progress = self.showProgress()
            APIService.getListTinInbox(boxid:self.boxID, page:self.pageNumber, pagesize:Constants.PAGE_SIZE) { (data, message) in
                self.hideProgress(progress)
                if let data = data {
                    self.listNews?.append(contentsOf: data.listNews)
                    self.uriimage = data.urlimage
                    self.collectionView.reloadData()
                    self.collectionView.infiniteScrollingView.stopAnimating()
                }else{
                    self.collectionView.infiniteScrollingView.stopAnimating()
                }
            }
        }
    }
    
    func loadData(){
        self.getListTinInbox(boxid:self.boxID, page:self.pageNumber, pagesize:Constants.PAGE_SIZE)
        callApiGroup.notify(queue: DispatchQueue.main, execute: {
            self.collectionView.reloadData()
        })
    }
    
    func getListTinInbox(boxid:String, page:Int, pagesize:Int){
        let progress = self.showProgress()
        self.callApiGroup.enter()
        APIService.getListTinInbox(boxid:boxid, page:page, pagesize:pagesize) { (data, message) in
            self.hideProgress(progress)
            if let data = data {
                self.listNews = data.listNews
                self.uriimage = data.urlimage
            }
            self.callApiGroup.leave()
        }
    }
}

extension NewsBoxViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listNews!.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = getItemWidth(boundWidth: collectionView.bounds.size.width, column:Constants.column)
        return CGSize(width: itemWidth, height: 280)
    }
    
    func getItemWidth(boundWidth: CGFloat, column:CGFloat) -> Int {
        let totalWidth = boundWidth - (Constants.offset) - (column) * Constants.minItemSpacing
        return Int(totalWidth / column)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        let listNewsObj = self.listNews![indexPath.row]
        let BoxName = listNewsObj.TenTin
        cell.lblTitle.text = BoxName
        
        let likeCount = listNewsObj.LikeCount
        cell.btnLike.setTitle(" \(likeCount)", for: .normal)
        cell.btnLike.setImage(FAKIonIcons.iosHeartIcon(withSize:20)?.image(with: CGSize(width: 20, height: 20))?.maskWithColor(color: UIColor.white), for: .normal)
        let viewCount = listNewsObj.Count
        cell.btnView.setTitle(" \(viewCount)", for: .normal)
        cell.btnView.setImage(FAKIonIcons.iosEyeIcon(withSize:20)?.image(with: CGSize(width: 20, height: 20))?.maskWithColor(color: UIColor.white), for: .normal)
        
        let resultURL = listNewsObj.image
        //let resultURL = self.uriimage! + "/\(image)"
        let urlString = resultURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        cell.imageThumb.contentMode = .scaleToFill
        cell.imageThumb.loadImageUsingUrlString(urlString: urlString!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listNewsObj = self.listNews![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsBoxDetailVC = storyboard.instantiateViewController(withIdentifier: "NewsBoxDetailVC") as! NewsBoxDetailViewController
        newsBoxDetailVC.descTitle = listNewsObj.TenTin
        newsBoxDetailVC.descNews = listNewsObj.Chitiet
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newsBoxDetailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
