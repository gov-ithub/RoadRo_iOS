//
//  HistoryViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  
  fileprivate var dataProvider: HistoryDataProvider!
  fileprivate var dataSource: ObjectsTableViewDataSource<ReportTableViewCell, ReportViewModel>!
  fileprivate var delegate: ObjectsTableViewDelegate<ReportTableViewCell>!
  
  fileprivate var config: Config
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    
    self.title = NSLocalizedString("Raportarile mele", comment: "")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = HistoryView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
