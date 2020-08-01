//
//  Toaster.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import UIKit
//import ISMessages

class Toast: NSObject {
    class func show(_ string: String) {
        ISMessages.showCardAlert(withTitle: "",
                                 message: string,
                                 duration: 2,
                                 hideOnSwipe: true,
                                 hideOnTap: true,
                                 alertType: ISAlertType.info,
                                 alertPosition: ISAlertPosition.top,
                                 didHide: nil)
    }
    
    class func showSuccess(_ string: String) {
        ISMessages.showCardAlert(withTitle: "Success",
                                 message: string,
                                 duration: 3,
                                 hideOnSwipe: true,
                                 hideOnTap: true,
                                 alertType: ISAlertType.success,
                                 alertPosition: ISAlertPosition.top,
                                 didHide: nil)
    }
    
    class func showErr(_ string: String) {
        ISMessages.showCardAlert(withTitle: "Error",
                                 message: string,
                                 duration: 3,
                                 hideOnSwipe: true,
                                 hideOnTap: true,
                                 alertType: ISAlertType.error,
                                 alertPosition: ISAlertPosition.top,
                                 didHide: nil)
    }
}
