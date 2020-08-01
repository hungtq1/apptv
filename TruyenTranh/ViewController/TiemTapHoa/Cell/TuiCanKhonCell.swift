//
//  TuiCanKhonCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class TuiCanKhonCell: UITableViewCell {
    @IBOutlet weak var lblTenVatPham: UILabel!
    @IBOutlet weak var lblSoLuong: UILabel!
    @IBOutlet weak var lblYeuCau: UILabel!
    var executeUse: ((IndexPath) -> Void)?
    var indexPath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(phapBao: PhapBao) {
        lblTenVatPham.text = phapBao.TenVatPham
        lblSoLuong.text = "Số lượng: \(phapBao.SoLuong)"
        lblYeuCau.text = "Yêu Cầu: \(phapBao.DangCapYeuCau.DangCapName)"
    }
    
    @IBAction func actionUse(_ sender: Any) {
        if let block = executeUse {
            block(indexPath)
        }
    }
}
