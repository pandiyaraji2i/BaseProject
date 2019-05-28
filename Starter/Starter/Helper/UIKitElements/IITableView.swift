//
//  RefreshableTableView.swift
//  RefreshableTableView
//
//  Created by ideas2it on 5/28/19.
//  Copyright © 2019 ideas2it. All rights reserved.
//

import UIKit

class IITableView: UITableView {
    
    fileprivate var refreshCtrl = UIRefreshControl()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addRefreshCtrl()
        self.tableFooterView = UIView()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.addRefreshCtrl()
        self.tableFooterView = UIView()
    }

    func addRefreshCtrl() {
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshCtrl
        } else {
            self.addSubview(refreshCtrl)
        }
    }
    
    func showEmptyLabel(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none;
    }
    
    func hideEmptyLabel() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
