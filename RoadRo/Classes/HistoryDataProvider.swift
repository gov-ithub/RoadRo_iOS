//
//  HistoryDataProvider.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryDataProvider: ObjectsNotificationControllerDelegate<DataReport>, ObjectsProvider {
  
  private var config: Config
  
  var reports: Results<DataReport>? {
    get {
      return self.results
    }
  }
  
  init(config: Config) {
    self.config = config
    
    super.init()
    self.results = self.config.dataStore.realm.objects(DataReport.self).sorted(byProperty: "id", ascending: true)
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfObjectsInSection(section: Int) -> Int {
    return self.reports?.count ?? 0
  }
  
  func objectAtIndexPath(indexPath: IndexPath) -> Any? {
    guard let reports = self.reports else {
      return nil
    }
    
    return reports[indexPath.row].viewModel()
  }
}
