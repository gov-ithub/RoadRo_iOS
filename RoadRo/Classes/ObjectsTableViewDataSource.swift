//
//  ObjectsTableViewDataSource.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ObjectsTableViewDataSource<CellType: UITableViewCell, ObjectType: Any>: NSObject, UITableViewDataSource {
  
  let cellReuseIdentifier : String
  let objectsProvider : ObjectsProvider
  let cellConfigurationHandler : (_ cell: CellType, _ object: ObjectType) -> Void
  
  weak var tableView : UITableView?
  
  init(tableView: UITableView, cellReuseIdentifier: String, objectsProvider: ObjectsProvider, cellConfiguration: @escaping ((_ cell: CellType, _ object: ObjectType) -> Void)) {
    self.cellReuseIdentifier = cellReuseIdentifier
    self.cellConfigurationHandler = cellConfiguration
    self.objectsProvider = objectsProvider
    
    self.tableView = tableView
    tableView.register(CellType.classForCoder(), forCellReuseIdentifier: self.cellReuseIdentifier)
    
    super.init()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    let number = self.objectsProvider.numberOfSections()
    return number
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let number = self.objectsProvider.numberOfObjectsInSection(section: section)
    return number
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CellType
    let object = self.objectsProvider.objectAtIndexPath(indexPath: indexPath) as! ObjectType
    cellConfigurationHandler(cell, object)
    return cell
  }
}
