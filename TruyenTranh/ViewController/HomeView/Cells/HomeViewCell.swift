//
//  HomeViewCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/3/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var imageThumb: CustomImageView!
    @IBOutlet weak var mySpaceHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.lineBreakMode = .byWordWrapping
        self.lblTitle.numberOfLines = 0
        self.btnLike.layer.cornerRadius = 6.0
        self.btnView.layer.cornerRadius = 6.0
        // Initialization code
    }

}
