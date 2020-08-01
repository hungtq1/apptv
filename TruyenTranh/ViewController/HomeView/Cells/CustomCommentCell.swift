//
//  CustomCommentCell.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/13/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import Cosmos

class CustomCommentCell: UITableViewCell {

    @IBOutlet weak var myAvatar: CustomImageView!
//    @IBOutlet weak var lblUserNameComment: UILabel!
//    @IBOutlet weak var lblDangCapName: UILabel!
//    @IBOutlet weak var lblCommentContent: UILabel!
//    @IBOutlet weak var lblDateCreate: UILabel!
//    @IBOutlet weak var btnAnswer: UIButton!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myAvatar.cornerRadius = 30.0
        self.myView.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
