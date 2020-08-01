//
//  SplashViewController.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/22/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var mySplashScreen: CustomImageView!
    @IBOutlet weak var iconLogo: UIImageView!
    let callApiGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iconLogo.cornerRadius = 16.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            if let window = UIApplication.shared.keyWindow {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    //get user profile
//                    if let userProfileJsonStr = UserDefaults.standard.string(forKey: Constants.USER_PROFILE) {
//                        Session.shared.userLogin = UserLogin(JSONString: userProfileJsonStr)!
//                    }
                    Session.shared.userLogin.user.ID = UserDefaults.standard.string(forKey: Constants.USER_ID) ?? ""
                    let mainVC = MainTabbarController.instantiateViewControllerFromStoryboard(storyboardName: .mainTabbar)
                    window.rootViewController = mainVC
                }
            }
        }
    }
}
