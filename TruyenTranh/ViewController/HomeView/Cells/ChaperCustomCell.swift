//
//  ChaperCustomCell.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/10/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import Cosmos

class ChaperCustomCell: UITableViewCell {

    @IBOutlet weak var chaperName: UILabel!
    @IBOutlet weak var chaperIcon: UIImageView!
   // @IBOutlet weak var viewTap: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
