//
//  UITableView+Extensions.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit
extension UITableView {
    // Set Empty message for Tableview
    func setEmptyMessageForTableView(dataSource: [Any], messageToDisplay: String) -> Int {
        if !dataSource.isEmpty {
            self.backgroundView = nil
            self.separatorStyle = .none
            return 1
        } else {
            let lblEmpty = UILabel()
            lblEmpty.textColor = .black
            lblEmpty.font = UIFont(name: "HelveticaNeue", size: 28)
            lblEmpty.textColor = UIColor.get(.appBackground)
            lblEmpty.text = messageToDisplay
            lblEmpty.textAlignment = .center
            self.backgroundView = lblEmpty
            self.separatorStyle = .none
            return 0
        }
    }

    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
      let cellIdentifier = String(describing: type)
      register(UINib(nibName: cellIdentifier, bundle: nil),
               forCellReuseIdentifier: identifier ?? cellIdentifier)
    }
}
