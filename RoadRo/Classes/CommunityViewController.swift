//
//  CommunityViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {
  
  fileprivate var dataProvider: HistoryDataProvider!
  fileprivate var dataSource: ObjectsTableViewDataSource<ReportTableViewCell, ReportViewModel>!
  fileprivate var delegate: ObjectsTableViewDelegate<ReportTableViewCell>!
  
  fileprivate var contentView: CommunityView { get { return self.view as! CommunityView } }
  fileprivate var config: Config
  
  var onSelectReport: ((_ model: ReportViewModel) -> Void)?
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    
    self.title = NSLocalizedString("Community", comment: "")
    self.tabBarItem = UITabBarItem(
      title: NSLocalizedString("Community", comment: ""),
      image: UIImage(named: "communityDisabled"),
      selectedImage: UIImage(named: "communityEnabled"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = CommunityView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Data source
    self.setupDatasource()
    
    // Refresh list
    self.doRefresh()
  }
  
  fileprivate func setupDatasource() {
    let tableView = self.contentView.tableView
    self.dataProvider = HistoryDataProvider(config: config)
    
    // Init data source
    let dataSource = ObjectsTableViewDataSource<ReportTableViewCell, ReportViewModel>(
      tableView: self.contentView.tableView,
      cellReuseIdentifier: "cell",
      objectsProvider: dataProvider
    ) {(cell, object) in
      cell.configure(model: object)
    }
    self.dataSource = dataSource
    
    let delegate = ObjectsTableViewDelegate<ReportTableViewCell>(
      tableView: self.contentView.tableView,
      heightConfiguration: {[weak self] (indexPath, width) -> CGFloat in
        let object = self?.dataProvider.objectAtIndexPath(indexPath: indexPath) as! ReportViewModel
        return ReportTableViewCell.desiredHeight(withModel: object, width: width)
      })
    delegate.selectionHandler = {[weak self] indexPath in
      if let object = self?.dataProvider.objectAtIndexPath(indexPath: indexPath) as? ReportViewModel {
        self?.onSelectReport?(object)
      }
    }
    
    self.delegate = delegate
    self.dataProvider.delegate = delegate
    
    tableView.dataSource = dataSource
    tableView.delegate = delegate
    tableView.refreshHandler = {[weak self] in
      self?.doRefresh()
    }
  }
  
  fileprivate func doRefresh() {
    self.config.dataProvider.doGetMyReports(dataStore: self.config.dataStore) {[weak self] (result, error) in
      self?.contentView.tableView.endRefreshing(animated: true)
      
      if let error = error {
        AlertView.show(withMessage: error)
        return
      }
    }
  }
}
