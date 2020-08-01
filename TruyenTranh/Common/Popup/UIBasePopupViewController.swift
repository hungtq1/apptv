//
//  UIBasePopupViewController.swift
//  Tikop
//
//  Created by Trung Hoang Van on 4/21/20.
//  Copyright © 2020 9Pay JSC. All rights reserved.
//

import UIKit

class UIBasePopupViewController: UIViewController, PopupContentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sizeForPopup(_ popupController: FLPopupViewController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        let height = UIScreen.main.bounds.size.height / 2
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: width - 50, height: max(300, height))
    }
}

class UIBasePopupNaviViewController: UINavigationController, PopupContentViewController {
    // PopupContentViewController Protocol
    func sizeForPopup(_ popupController: FLPopupViewController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        let height = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width
        return CGSize(width: width - 40, height: max(300, height - 150))
    }
}
