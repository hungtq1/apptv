//
//  TopChartCell.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/14/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import Cosmos

class TopChartCell: UITableViewCell {

    @IBOutlet weak var myAvatar: CustomImageView!
    @IBOutlet weak var lblTitle_Head: UILabel!
    @IBOutlet weak var lblTitle_Small: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var iconNumber: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myAvatar.cornerRadius = 20.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
