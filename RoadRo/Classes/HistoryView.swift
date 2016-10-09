//
//  HistoryView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class HistoryView: UIView {
  
  var tableView: TableView = {
    let tableView = TableView()
    tableView.noContentMessage = NSLocalizedString("Nu ai adăugat nicio sesizare", comment: "")
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    return tableView
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.backgroundColor()
    
    // Table
    self.addSubview(tableView)
    constrain(tableView) { view in
      view.edges == view.superview!.edges
    }
  }
}
