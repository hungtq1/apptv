//
//  DanhSachGiaoDichCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/6/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class DanhSachGiaoDichCell: UITableViewCell {
    @IBOutlet weak var lblTieuDeChap: UILabel!
    @IBOutlet weak var lblNumberKNB: UILabel!
    @IBOutlet weak var lblNgayMua: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(chapterBuy: ChapterBuy) {
        lblTieuDeChap.text = chapterBuy.TieuDeChap
        lblNumberKNB.text = "Giá \(chapterBuy.NumberKNB) tiên linh thạch"
        lblNgayMua.text = chapterBuy.NgayMua.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSZ.rawValue)?.toString(format: DateFormat.HHmmDDMMYYYY)
    }
}
