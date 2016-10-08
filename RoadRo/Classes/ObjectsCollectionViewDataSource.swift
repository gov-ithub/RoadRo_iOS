//
//  ObjectsCollectionViewDataSource.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ObjectsCollectionViewDataSource<CellType: UICollectionViewCell, ObjectType: Any>: NSObject, UICollectionViewDataSource {
  
  let cellReuseIdentifier : String
  let objectsProvider : ObjectsProvider
  let cellConfigurationHandler : (_ cell: CellType,_ object: ObjectType) -> Void
  
  init(collectionView: UICollectionView, cellReuseIdentifier: String, objectsProvider: ObjectsProvider, cellConfiguration: @escaping ((_ cell: CellType,_  object: ObjectType) -> Void)) {
    self.cellReuseIdentifier = cellReuseIdentifier
    self.cellConfigurationHandler = cellConfiguration
    self.objectsProvider = objectsProvider
    
    collectionView.register(CellType.classForCoder(), forCellWithReuseIdentifier: self.cellReuseIdentifier)
    super.init()
  }
  
  private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    let number = self.objectsProvider.numberOfSections()
    return number
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let number = self.objectsProvider.numberOfObjectsInSection(section: section)
    return number
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as! CellType
    let object = self.objectsProvider.objectAtIndexPath(indexPath: indexPath) as! ObjectType
    cellConfigurationHandler(cell, object)
    return cell
  }
}
