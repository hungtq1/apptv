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
import DropDown

@objc protocol FLComboBoxDelegate: class {
    @objc optional func fwComboBox(comboBox: FLComboBox, didSelectAtIndex index: Int)
    @objc optional func fwComboBoxWillShow(comboBox: FLComboBox)
}
class FLComboBox: UIView, UIGestureRecognizerDelegate {

    private lazy var dropDown = DropDown()
    let titleLabel = UILabel()

    weak var delegate: FLComboBoxDelegate?
    private var paddingLeftConstraint: NSLayoutConstraint!
    private var paddingRightConstraint: NSLayoutConstraint!

    var defaultTitle: String = ""

    @IBInspectable var paddingLeft: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var paddingRight: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var bottomOffset: CGFloat = 0 {
        didSet {
            dropDown.bottomOffset = CGPoint(x: 0, y: bottomOffset)
        }
    }

    @IBInspectable var topOffset: CGFloat = 0 {
        didSet {
            dropDown.topOffset = CGPoint(x: 0, y: -topOffset)
        }
    }

    @IBInspectable var showArrow = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var arrowImage: UIImage? {
        didSet {
            if let image = arrowImage {
                arrowLabel.image = image
            }
        }
    }
    
    var arrowLabel = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    
    var comboTextAlignment = NSTextAlignment.left {
        didSet {
            titleLabel.textAlignment = comboTextAlignment
        }
    }

    var direction: DropDown.Direction = .any {
        didSet {
            dropDown.direction = direction
        }
    }

    var dataSource = [String]() {
        didSet {
            dropDown.dataSource = dataSource
            self.titleLabel.text = dropDown.selectedItem ?? defaultTitle
        }
    }

    var currentRow: Int? {
        get {
            return dropDown.indexForSelectedRow
        }
    }
    
//    var arrowLabel: UILabel = {
//        var label = UILabel()
//        label.text = "▽"
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.sizeToFit()
//        return label
//    }()

    func selectRow(atIndex: Int?) {
        dropDown.selectRow(at: atIndex)
        self.titleLabel.text = dropDown.selectedItem ?? defaultTitle
    }

    func setup() {
        self.clipsToBounds = true
        dropDown.anchorView = self
//        dropDown.shadow
        dropDown.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: dropDown.bounds.height))
        shadowPath.addLine(to: CGPoint(x: dropDown.bounds.width, y: dropDown.bounds.height))
        shadowPath.addLine(to: CGPoint(x: dropDown.bounds.width, y: dropDown.bounds.height + 7.0))
        shadowPath.addLine(to: CGPoint(x: 0, y: dropDown.bounds.height + 7.0))
        shadowPath.close()
        
        dropDown.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dropDown.layer.shadowOpacity = 0.5
        dropDown.layer.masksToBounds = false
        dropDown.layer.shadowPath = shadowPath.cgPath
        dropDown.layer.shadowRadius = 2
        //
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            if self != nil {
                self!.delegate?.fwComboBox?(comboBox: self!, didSelectAtIndex: index)
                self!.titleLabel.text = item
            }
        }
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textAlignment = comboTextAlignment
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: paddingLeft, y: 0, width: bounds.size.width - paddingLeft - paddingRight - (showArrow ? arrowLabel.bounds.size.width + paddingRight : 0) - 100, height: bounds.size.height)
        if showArrow {
            arrowLabel.frame = CGRect(x: bounds.size.width - paddingRight - arrowLabel.bounds.size.width, y: (bounds.size.height - arrowLabel.bounds.size.height) / 2.0, width: arrowLabel.bounds.size.width, height: arrowLabel.bounds.size.height)
            self.addSubview(arrowLabel)
        }
        titleLabel.text = defaultTitle
        self.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchedSelf))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    @objc private func touchedSelf(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            delegate?.fwComboBoxWillShow?(comboBox: self)
            dropDown.show()
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: paddingLeft, y: 0, width: bounds.size.width - paddingLeft - paddingRight - (showArrow ? arrowLabel.bounds.size.width + paddingRight : 0) - 100, height: bounds.size.height)
        if showArrow {
            arrowLabel.frame = CGRect(x: bounds.size.width - paddingRight - arrowLabel.bounds.size.width, y: (bounds.size.height - arrowLabel.bounds.size.height) / 2.0, width: arrowLabel.bounds.size.width, height: arrowLabel.bounds.size.height)
            if arrowLabel.superview != self {
                self.addSubview(arrowLabel)
            }
        } else {
            arrowLabel.removeFromSuperview()
        }
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)!)
    }

    deinit {
        print("deinit combobox")
    }

}
