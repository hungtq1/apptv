/// Flex Digital Health CONFIDENTIAL
/// Copyright (c) 2017-2018 Flex Digital Health, All Rights Reserved.
///
/// NOTICE:  All information contained herein is, and remains the property of Flex Digital Health. The intellectual and technical concepts contained
/// herein are proprietary to Flex Digital Health and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
/// from Flex Digital Health.  Access to the source code contained herein is hereby forbidden to anyone except current Flex Digital Health employees, managers or contractors who have executed 
/// Confidentiality and Non-disclosure agreements explicitly covering such access.
///
/// The copyright notice above does not evidence any actual or intended publication or disclosure  of  this source code, which includes  
/// information that is confidential and/or proprietary, and is a trade secret, of  Flex Digital Health Incorporated.   ANY REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC  PERFORMANCE, 
/// OR PUBLIC DISPLAY OF OR THROUGH USE  OF THIS  SOURCE CODE  WITHOUT  THE EXPRESS WRITTEN CONSENT OF COMPANY IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE 
/// LAWS AND INTERNATIONAL TREATIES.  THE RECEIPT OR POSSESSION OF  THIS SOURCE CODE AND/OR RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS  
/// TO REPRODUCE, DISCLOSE OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT  MAY DESCRIBE, IN WHOLE OR IN PART.

import UIKit

class FWFloatingLabelTextView: UITextView {

    let animationDuration = 0.3
    let placeholderTextColor = UIColor.lightGray.withAlphaComponent(0.65)
    fileprivate var isIB = false
    fileprivate var title = UILabel()
    fileprivate var hintLabel = UILabel()
    fileprivate var initialTopInset: CGFloat = 0

    // MARK: - Properties
    override var accessibilityLabel: String? {
        get {
            if text.isEmpty {
                return title.text!
            } else {
                return text
            }
        }
        set {
        }
    }

    var titleFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            title.font = titleFont
        }
    }

    @IBInspectable var hint: String = "" {
        didSet {
            title.text = hint
            title.sizeToFit()
            var r = title.frame
            r.size.width = frame.size.width
            title.frame = r
            hintLabel.text = hint
            hintLabel.sizeToFit()
        }
    }

    @IBInspectable var hintYPadding: CGFloat = 0.0 {
        didSet {
            adjustTopTextInset()
        }
    }

    @IBInspectable var titleYPadding: CGFloat = 0.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }

    @IBInspectable var titleTextColour: UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }

    @IBInspectable var titleActiveTextColour: UIColor = UIColor.cyan {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    deinit {
        if !isIB {
            let nc = NotificationCenter.default
            nc.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
            nc.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: self)
            nc.removeObserver(self, name: UITextView.textDidEndEditingNotification, object: self)
        }
    }

    // MARK: - Overrides
    override func prepareForInterfaceBuilder() {
        isIB = true
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        adjustTopTextInset()
        hintLabel.alpha = text.isEmpty ? 1.0 : 0.0
        let r = textRect()
        hintLabel.frame = CGRect(x: r.origin.x, y: r.origin.y, width: hintLabel.frame.size.width, height: hintLabel.frame.size.height)
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if isResp && !text.isEmpty {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if text.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
    }

    // MARK: - Private Methods
    fileprivate func setup() {
        initialTopInset = textContainerInset.top
        textContainer.lineFragmentPadding = 0.0
        titleActiveTextColour = tintColor
        // Placeholder label
        hintLabel.font = font
        hintLabel.text = hint
        hintLabel.numberOfLines = 0
        hintLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hintLabel.backgroundColor = UIColor.clear
        hintLabel.textColor = placeholderTextColor
        insertSubview(hintLabel, at: 0)
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        title.backgroundColor = backgroundColor
        if !hint.isEmpty {
            title.text = hint
            title.sizeToFit()
        }
        self.addSubview(title)
        // Observers
        if !isIB {
            let nc = NotificationCenter.default
            nc.addObserver(self, selector: #selector(UIView.layoutSubviews), name:
                UITextView.textDidChangeNotification, object: self)
            nc.addObserver(self, selector: #selector(UIView.layoutSubviews), name: UITextView.textDidBeginEditingNotification, object: self)
            nc.addObserver(self, selector: #selector(UIView.layoutSubviews), name: UITextView.textDidEndEditingNotification, object: self)
        }
    }

    fileprivate func adjustTopTextInset() {
        var inset = textContainerInset
        inset.top = initialTopInset + title.font.lineHeight + hintYPadding
        textContainerInset = inset
    }

    fileprivate func textRect() -> CGRect {
//        var r = UIEdgeInsetsInsetRect(bounds, contentInset)
        var r = bounds.inset(by: contentInset)
        r.origin.x += textContainer.lineFragmentPadding
        r.origin.y += textContainerInset.top
        return r.integral
    }

    fileprivate func setTitlePositionForTextAlignment() {
        var titleLabelX = textRect().origin.x
        var placeholderX = titleLabelX
        if textAlignment == NSTextAlignment.center {
            titleLabelX = (frame.size.width - title.frame.size.width) * 0.5
            placeholderX = (frame.size.width - hintLabel.frame.size.width) * 0.5
        } else if textAlignment == NSTextAlignment.right {
            titleLabelX = frame.size.width - title.frame.size.width
            placeholderX = frame.size.width - hintLabel.frame.size.width
        }
        var r = title.frame
        r.origin.x = titleLabelX
        title.frame = r
        r = hintLabel.frame
        r.origin.x = placeholderX
        hintLabel.frame = r
    }

    fileprivate func showTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations: {
                // Animation
                self.title.alpha = 1.0
                var r = self.title.frame
                r.origin.y = self.titleYPadding + self.contentOffset.y
                self.title.frame = r
            }, completion: nil)
    }

    fileprivate func hideTitle(_ animated: Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay: 0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations: {
                // Animation
                self.title.alpha = 0.0
                var r = self.title.frame
                r.origin.y = self.title.font.lineHeight + self.hintYPadding
                self.title.frame = r
            }, completion: nil)
    }

}
