//
//  FWCustomScrollView.swift
//  iCNM
//
//  Created by Medlatec on 5/15/17.
//  Copyright © 2017 Medlatec. All rights reserved.
//

import UIKit

class FWCustomScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delaysContentTouches = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delaysContentTouches = false
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UITextField || view is UITextView || view is UIControl {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }

}
