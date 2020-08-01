//
//  MainTabbarController.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import FontAwesomeKit

class MainTabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers(self.getTabbarViewController(), animated: true)
        self.configureTabbarItem()
        self.selectedIndex = 0
        self.delegate = self
    }
    
    func configureTabbarItem() {
        let itemStore = self.tabBar.items![1]
        itemStore.title = "Phòng Tu Luyện".localized
        itemStore.image = FAKIonIcons.bonfireIcon(withSize: 24)?.image(with: CGSize(width: 24, height: 24))
        
        let itemHome = self.tabBar.items![0]
        itemHome.title = "Trang chủ".localized
        itemHome.image = FAKIonIcons.iosHomeIcon(withSize: 24)?.image(with: CGSize(width: 24, height: 24))
        let itemAccount = self.tabBar.items![2]
        itemAccount.title = "Thành viên".localized
        itemAccount.image = UIImage(named: "user")
    }
        
    func getTabbarViewController() -> [UIViewController] {
        var viewController = [UIViewController]()
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let bookVC = UIStoryboard(name: "BookStore", bundle: nil).instantiateViewController(withIdentifier: "ListComicViewController")
        let moreVC = UIStoryboard(name: "More", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController")
        viewController.append(contentsOf: [homeVC, bookVC, moreVC])
        return viewController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
