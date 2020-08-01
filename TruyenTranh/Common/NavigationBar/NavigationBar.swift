//
//  NavigationBar.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/15/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    private static let NIB_NAME = "NavigationBar"
    @IBOutlet private var view: UIView!
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(NavigationBar.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }

}
