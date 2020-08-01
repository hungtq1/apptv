//
//  LichSuLinhThachCell.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/6/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class LichSuLinhThachCell: UITableViewCell {
    @IBOutlet weak var lblKeyTrans: UILabel!
    @IBOutlet weak var lblTypeChange: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblNgayNap: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(trans: HistoryLinhThach) {
        switch trans.TypeCharge {
        case 1:
            lblTypeChange.text = "Chuyển khoản"
            lblKeyTrans.text = trans.Key_Trans
        case 3:
            lblTypeChange.text = "Nạp thẻ"
            let key_trans = trans.Key_Trans.components(separatedBy: " - ")
            lblKeyTrans.text = "Seri: \(key_trans.first ?? "") - Mã thẻ: \(key_trans[1])"
        default:
            print("Nothing to do")
        }
        
        lblStatus.text = trans.Status == 0 ? "Thành công" : "Chờ xử lý"
        lblStatus.textColor = trans.Status == 0 ? UIColor.gray : UIColor.orange
        lblNgayNap.text = trans.NgayNap.toDate(dateFormat: DateFormat.yyyyMMddHHmmssSSSZ.rawValue)?.toString(format: DateFormat.HHmmDDMMYYYY)
    }
}
