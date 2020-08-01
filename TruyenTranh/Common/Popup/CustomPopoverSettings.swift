//
//  CustomPopoverSettings.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import UIKit

protocol CustomPopoverSettingsDelegate {
    func gobackView(index:Int)
}

class CustomPopoverSettings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    var delegate:CustomPopoverSettingsDelegate?
    var listItems:[String]? = ["Hướng dẫn đọc truyện", "Chia sẻ", "Báo lỗi Chương"]
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        self.myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if let item = listItems?[indexPath.row]{
            if indexPath.row == 0{
                cell.contentView.backgroundColor = UIColor.init(hex: "23B1F1")
            }else if indexPath.row == 1{
                cell.contentView.backgroundColor = UIColor.init(hex: "31AAB0")
            }else{
                cell.contentView.backgroundColor = UIColor.red
            }
            cell.textLabel?.text = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.gobackView(index:indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
}
