//
//  TextFieldExtension.swift
//  MicroInvestment
//
//  Created by Trung Hoang Van on 12/20/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import UIKit

extension UITextField {
    @IBDesignable
    class DesignableUITextField: UITextField {

        // Provides left padding for images
        override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leftPadding
            return textRect
        }

        @IBInspectable var leftImage: UIImage? {
            didSet {
                updateView()
            }
        }

        @IBInspectable var leftPadding: CGFloat = 0

        @IBInspectable var color: UIColor = UIColor.lightGray {
            didSet {
                updateView()
            }
        }

        func updateView() {
            if let image = leftImage {
                leftViewMode = UITextField.ViewMode.always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
                imageView.tintColor = color
                leftView = imageView
            } else {
                leftViewMode = UITextField.ViewMode.never
                leftView = nil
            }

            // Placeholder text color
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        }
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector, maximumDate: Date, minimumDate: Date?) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.maximumDate = maximumDate
        if let minimumDate = minimumDate {
            datePicker.minimumDate = minimumDate
        }
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    func setInputPickerView(target: Any, selector: Selector, dataSource: UIPickerViewDataSource, delegate: UIPickerViewDelegate) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        pickerView.dataSource = dataSource
        pickerView.delegate = delegate
        self.inputView = pickerView
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
