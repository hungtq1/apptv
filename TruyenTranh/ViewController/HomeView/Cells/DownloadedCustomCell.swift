//
//  DownloadedCustomCell.swift
//  TruyenTranh
//
//  Created by Tạ Quang Hùng on 5/28/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit
import Cosmos

class DownloadedCustomCell: UITableViewCell {

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var deleteIcon: UIImageView!
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
