//
//  ColorExtension.swift
//  MicroInvestment
//
//  Created by Trung Hoang Van on 12/10/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    @nonobjc class var dullBlue: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 132.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var cerulean: UIColor {
        return UIColor(red: 0.0, green: 159.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var coolGrey: UIColor {
        return UIColor(red: 188.0 / 255.0, green: 187.0 / 255.0, blue: 193.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var disabledGrey: UIColor {
        
        return UIColor(red:0.85, green:0.84, blue:0.81, alpha:1.0)
    }
    
    @nonobjc class var pumpkin: UIColor {
        
        return UIColor(red: 212.0 / 255.0, green: 118.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var battleshipGrey: UIColor {
        return UIColor(red: 108.0 / 255.0, green: 114.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkblue: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 21.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var navy: UIColor {
        return UIColor(red: 0 / 255.0, green: 20.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var primary: UIColor {
        return UIColor(red: 0/255, green: 85.0/255.0, blue: 162.0/255.0, alpha: 1.0)
        //UIColor(red: 0 / 255.0, green: 20.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var incomingMessage: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
}
