//
//  TruyenTaiVeCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/27/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TruyenTaiVeCell: UITableViewCell {
    @IBOutlet weak var lblStoryName: UILabel!
    var executeDelete: ((Int) -> Void)?
    var indexPath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionDeleteDownload(_ sender: Any) {
        if let block = executeDelete {
            block(indexPath.row)
        }
    }
}
