//
//  TiemTapHoaCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TiemTapHoaCell: UITableViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
