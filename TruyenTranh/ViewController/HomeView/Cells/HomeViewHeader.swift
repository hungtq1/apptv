//
//  HomeViewHeader.swift
//  TruyenTranh
//
//  Created by Mac osx on 7/18/17.
//  Copyright © 2017 Hung. All rights reserved.
//

import UIKit

class HomeViewHeader: UICollectionReusableView {
    @IBOutlet weak var iconHeader: UIImageView!
    @IBOutlet weak var icArrow: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // addShadow(cell: self)
        self.titleHeader.backgroundColor = .clear
        self.titleHeader.layer.masksToBounds = false
        self.titleHeader.layer.shadowOffset = CGSize(width: 0, height:0)
        self.titleHeader.layer.shadowColor = UIColor.gray.cgColor
        self.titleHeader.layer.shadowOpacity = 0.3
        self.titleHeader.layer.shadowRadius = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //titleHeader.frame = bounds
    }
}
