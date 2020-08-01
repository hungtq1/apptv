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

class FWFloatingLabelTextField: UITextField {

    fileprivate var topSpaceForLabel: CGFloat = 6.0
    fileprivate var heightWithoutError: CGFloat = 50.0
    fileprivate var errorLabelTopPadding: CGFloat = 4.0
    var validateBlock: (() -> (String?))?

    override public var borderStyle: UITextField.BorderStyle {
        didSet {
            guard borderStyle != oldValue else { return }
            borderStyle = .none
        }
    }

    fileprivate var bottomLineView: UIView?
    fileprivate var labelPlaceholder: UILabel?
    fileprivate var labelError: FWTextFieldErrorLabel?
    fileprivate var isFloating = false
    fileprivate var tempPlaceholderRect: CGRect = CGRect.zero

    @IBInspectable var messageForValidatingLength: String = "This field cannot be blank"
    @IBInspectable var isMandatory: Bool = true
    @IBInspectable var validateOnResign: Bool = false
    @IBInspectable var validateOnChange: Bool = false
    fileprivate var arrRegx = [[String: Any]]()
//    fileprivate var placeholderLabelKey = "_placeholderLabel.textColor"
    fileprivate var errorMessage: String? {
        didSet {
            labelError?.text = errorMessage
            floatTheLabel()
        }
    }

    @IBInspectable open var disableFloatingLabel: Bool = false
    @IBInspectable open var padding: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable open var iconString: String? = nil {
        didSet {
            updateView()
        }
    }

    @IBInspectable open var iconColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }

    @IBInspectable open var errorColor: UIColor = .red {
        didSet {
            labelError?.textColor = errorColor
            floatTheLabel()
        }
    }

    @IBInspectable open var lineColor: UIColor = .gray
    @IBInspectable open var selectedLineColor: UIColor = UIColor(red: 19 / 256.0, green: 141 / 256.0, blue: 117 / 256.0, alpha: 1.0)

    @IBInspectable open var placeholderColor: UIColor = .lightGray
    @IBInspectable open var selectedPlaceholderColor: UIColor = UIColor(red: 19 / 256.0, green: 141 / 256.0, blue: 117 / 256.0, alpha: 1.0)

    override var placeholder: String? {
        willSet {
            if newValue != "" {
                self.labelPlaceholder?.text = newValue
            }
        }
    }

    override var text: String? {
        didSet {
            if !self.disableFloatingLabel && text != nil && text != "" {
                self.placeholder = ""
            }
            if (text == nil || text == "") && tempPlaceholderRect.size == CGSize.zero {
                tempPlaceholderRect = super.placeholderRect(forBounds: self.bounds)
            }
            floatTheLabel()
        }
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.y += topSpaceForLabel - (self.labelError?.bounds.size.height ?? 0) / 2.0
        return rect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.y += topSpaceForLabel - (self.labelError?.bounds.size.height ?? 0) / 2.0
        return rect
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.y += topSpaceForLabel - (self.labelError?.bounds.size.height ?? 0) / 2.0
        return rect
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += padding
        rect.origin.y += topSpaceForLabel
        rect.size.height -= (self.labelError?.bounds.size.height ?? 0)
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x += padding
        rect.origin.y += topSpaceForLabel
        rect.size.height -= (self.labelError?.bounds.size.height ?? 0)
        return rect
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        tempPlaceholderRect = rect
        self.labelPlaceholder?.frame = tempPlaceholderRect
        return rect
    }

    fileprivate func updateView() {
        if let icon = iconString {
            leftViewMode = .always
            let iconLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            iconLabel.font = UIFont(name: "FontAwesome", size: 15.0)
            iconLabel.textColor = iconColor
            iconLabel.text = icon
            leftView = iconLabel

        } else {
            leftViewMode = .never
            leftView = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if bottomLineView != nil {
            let temp: CGFloat = isFirstResponder ? 2.0 : 1.0
            bottomLineView?.frame = CGRect(x: 0, y: heightWithoutError - temp, width: self.frame.width, height: temp)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

fileprivate extension FWFloatingLabelTextField {
    fileprivate func initialize() {
        self.clipsToBounds = true
        borderStyle = .none
        addBottomLine()
        addFloatingLabel()
        addErrorLabel()
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: self)
    }

    @objc func textDidChange(_ : Notification) {
        if self.validateOnChange {
            self.validate()
        }
    }

    fileprivate func addErrorLabel() {
        labelError = FWTextFieldErrorLabel()
        labelError?.topPadding = errorLabelTopPadding
        labelError?.font = self.font?.withSize(12.0)
        labelError?.translatesAutoresizingMaskIntoConstraints = false
        labelError?.numberOfLines = 0
        labelError?.lineBreakMode = .byWordWrapping
        labelError?.textColor = errorColor
        self.addSubview(labelError!)
        NSLayoutConstraint(item: labelError!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: heightWithoutError).isActive = true
        NSLayoutConstraint(item: labelError!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: labelError!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: labelError!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        let temp = NSLayoutConstraint(item: labelError!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        temp.priority = UILayoutPriority(rawValue: 999)
        temp.isActive = true
        labelError?.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
    }

    fileprivate func addBottomLine() {
        bottomLineView?.removeFromSuperview()
        bottomLineView = UIView(frame: CGRect(x: 0, y: heightWithoutError - 1, width: self.frame.width, height: 1))
        bottomLineView?.backgroundColor = lineColor
        if bottomLineView != nil {
            self.addSubview(bottomLineView!)
        }
    }

    fileprivate func addFloatingLabel() {
        labelPlaceholder?.removeFromSuperview()
        var placeholderText: String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        labelPlaceholder?.font = self.font
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeholderColor
        labelPlaceholder?.isHidden = true
//        self.setValue(placeholderColor, forKeyPath: placeholderLabelKey)
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
    }

    fileprivate func floatTheLabel() {
        if self.text == "" && self.isFirstResponder {
            floatPlaceholder(selected: true)
        } else if self.text == "" && !self.isFirstResponder {
            resignPlaceholder()
        } else if self.text != "" && !self.isFirstResponder {
            floatPlaceholder(selected: false)
        } else if self.text != "" && self.isFirstResponder {
            floatPlaceholder(selected: true)
        }
    }

    // MARK: - Float UITextfield Placeholder Label
    fileprivate func floatPlaceholder(selected: Bool) {
        self.isFloating = true
        labelPlaceholder?.isHidden = false
        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.size.height = 2.0
        if selected {
            bottomLineView?.backgroundColor = (errorMessage == nil ? selectedLineColor : errorColor)
            self.labelPlaceholder?.textColor = selectedPlaceholderColor
            bottomLineFrame?.origin.y = heightWithoutError - 2.0
//            self.setValue(selectedPlaceholderColor, forKeyPath: placeholderLabelKey)

        } else {
            bottomLineView?.backgroundColor = (errorMessage == nil ? lineColor : errorColor)
            bottomLineFrame?.origin.y = heightWithoutError - 1.0
            self.labelPlaceholder?.textColor = placeholderColor
//            self.setValue(self.placeholderColor, forKeyPath: placeholderLabelKey)

        }

        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            return
        }

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.labelPlaceholder?.transform.a = 0.86
            self.labelPlaceholder?.transform.d = 0.86
            self.labelPlaceholder?.sizeToFit()
            self.labelPlaceholder?.center = CGPoint(x: 0.0, y: 0.0)
            self.bottomLineView?.frame = bottomLineFrame!
        })
    }

    // MARK: - Resign the Placeholder
    fileprivate func resignPlaceholder() {
        self.isFloating = false
//        self.setValue(self.placeholderColor, forKeyPath: placeholderLabelKey)

        var bottomLineFrame = bottomLineView?.frame
        bottomLineFrame?.origin.y = heightWithoutError - 1
        bottomLineFrame?.size.height = 1.0
        bottomLineView?.backgroundColor = (errorMessage == nil ? lineColor : errorColor)

        if disableFloatingLabel {
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = placeholderColor
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomLineView?.frame = bottomLineFrame!
            })
            return
        }

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.labelPlaceholder?.transform.a = 1.0
            self.labelPlaceholder?.transform.d = 1.0
            self.labelPlaceholder?.textColor = self.placeholderColor
            self.labelPlaceholder?.frame = self.tempPlaceholderRect
            self.bottomLineView?.frame = bottomLineFrame!
        }, completion: { _ in
            if !self.isFloating {
                self.labelPlaceholder?.isHidden = true
                self.placeholder = self.labelPlaceholder?.text
            }
        })
    }

    // MARK: - UITextField Begin Editing.
    fileprivate func textFieldDidBeginEditing() {
        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
    }

    func textFieldDidEndEditing() {
        if validateOnResign {
            self.validate()
        }
        self.floatTheLabel()
    }
}

extension FWFloatingLabelTextField {
    func addRegx(strRegx: String, errorMsg: String) {
        let dic = ["regx": strRegx, "msg": errorMsg]
        arrRegx.append(dic)
    }

    private func validateString(stringToSearch: String, withRegex: String) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", withRegex)
        return regex.evaluate(with: stringToSearch)
    }

    func removeAllRegx() {
        arrRegx.removeAll()
    }

    @discardableResult
    func validate() -> Bool {
        if isMandatory {
            if let length = self.text?.count {
                if length == 0 {
                    errorMessage = messageForValidatingLength
                    return false
                }
            } else {
                errorMessage = messageForValidatingLength
                return false
            }
        }
        for dic in arrRegx {
            if let regx = dic["regx"] as? String, !regx.isEmpty, let text = self.text, !text.isEmpty {
                if !self.validateString(stringToSearch: text, withRegex: regx) {
                    errorMessage = dic["msg"] as? String
                    return false
                }
            }
        }

        if let validateBlck = validateBlock {
            let message = validateBlck()
            if message != nil {
                errorMessage = message!
                return false
            }
        }
        errorMessage = nil
        return true
    }
}
