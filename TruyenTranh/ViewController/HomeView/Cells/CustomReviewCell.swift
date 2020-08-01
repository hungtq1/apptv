//
//  CustomReviewCell.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/10/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import Cosmos

class CustomReviewCell: UITableViewCell {

    @IBOutlet weak var myAvatar: CustomImageView!
    @IBOutlet weak var userNameReview: UILabel!
    @IBOutlet weak var contentReview: UILabel!
    @IBOutlet weak var dateCreate: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myAvatar.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
