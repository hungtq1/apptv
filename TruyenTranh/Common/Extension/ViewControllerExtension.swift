//
//  ViewControllerExtension.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/6/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import UIKit
import SVProgressHUD

enum StoryBoardName: String {
    case home = "Home"
    case login = "Login"
    case search = "Search"
    case popup = "Popup"
    case withdraw = "Withdraw"
    case more = "More"
    case mainTabbar = "MainTabbar"
    case device = "Device"
    case signup = "SignUp"
    case main = "Main"
    case history = "History"
    case profile = "Profile"
    case community = "Community"
    case onboarding = "OnBoarding"
    case tiemTapHoa = "TiemTapHoa"
    case performance = "Performance"
    case truyenTaiVe = "TruyenTaiVe"
    case transaction = "Transaction"
    case notification = "Notification"
}

typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showLoading() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setForegroundColor(UIColor(red: 0/255, green: 154/255, blue: 221/255, alpha: 1.0))
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func hideNavBar() {
        let nav = self.navigationController?.navigationBar
        let transparentPixel = UIImage()
        nav?.setBackgroundImage(transparentPixel, for: UIBarMetrics.default)
        nav?.shadowImage = transparentPixel
        nav?.isTranslucent = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Instantiate
    
    class func instantiateFromStoryboard(storyboardName: StoryBoardName, storyboardId: String) -> Self {
        
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, storyboardId: storyboardId)
    }
    
    class func instantiateViewControllerFromStoryboard(storyboardName: StoryBoardName) -> Self {
        
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, storyboardId: self.className)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: StoryBoardName, storyboardId: String) -> T {
        
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    func topController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topController(controller: presented)
        }
        return controller ?? UIViewController()
    }
}

// MARK: - Simple Alert View

extension UIViewController {
    
    func presentSimpleAlertView(_ message: String, completion: ((_ tag: Int) -> Void)?) -> Void {
        self.presentSimpleAlertView(message, 0) { tag in
            if let block = completion {
                block(tag)
            }
        }
    }
    
    func presentSimpleAlertView(_ message: String, _ tag: Int, completion: ((_ tag: Int) -> Void)?) -> Void {
        self.presentSimpleAlertView(Constants.APP_NAME, message, tag) { tag in
            if let block = completion {
                block(tag)
            }
        }
    }
    
    func presentSimpleAlertView(_ title: String = Constants.APP_NAME, _ message: String, _ tag: Int = 0, completion: ((_ tag: Int) -> Void)?) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .destructive, handler: {(action) -> Void in
            if let block = completion {
                block(tag)
            }
        })
        
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Confirm alert view

extension UIViewController {
    
    func presentConfirmAlertView(title: String = Constants.APP_NAME,
                                 message: String,
                                 okTitle: String = Constants.OK_BUTTON,
                                 cancelTitle: String = Constants.CANCEL_BUTTON,
                                 completion: @escaping (_ isOk: Bool) -> Void) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: okTitle, style: .default, handler: {(action) -> Void in
            completion(true)
        })
        let actionCancel: UIAlertAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: {(action) -> Void in
            completion(false)
        })
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}

extension UIAlertController.Style {
    
    func controller(title: String? = nil, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        return _controller
    }
}

extension String {
    
    func alertAction(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
