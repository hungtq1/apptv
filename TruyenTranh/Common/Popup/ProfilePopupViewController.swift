//
//  ProfilePopupViewController.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/13/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import UIKit

class ProfilePopupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitlePopup: UILabel!
    var titleStr = ""
    var listItem = [String]()
    var selectItemBlock: ((String) -> Void)?
    var itemSelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lblTitlePopup.text = titleStr
        self.tableView.set(delegateAndDataSource: self)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedItem(_ sender: Any) {
        if let block = selectItemBlock {
            block(itemSelected)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfilePopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listItem[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected = listItem[indexPath.row]
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .blue
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
    }
}
