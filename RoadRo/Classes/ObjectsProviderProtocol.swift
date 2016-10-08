//
//  ObjectsProviderProtocol.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//


import Foundation

@objc protocol ObjectsProvider: class {
  
  weak var delegate : ObjectsProviderDelegate? { get set }
  
  func numberOfSections() -> Int
  
  func numberOfObjectsInSection(section: Int) -> Int
  
  func objectAtIndexPath(indexPath: IndexPath) -> Any?
  
  @objc optional func titleForSection(section: Int) -> String
  
}

protocol ShowMoreObjectsProvider: ObjectsProvider {
  
  func addMoreObjects()
  
  // Returns true if it has objects that are not yet displayed
  func canShowMore() -> Bool
  
  // Returns the number of comments that are selected for display
  func selectedComments() -> (Int, Int)
}

@objc protocol ObjectsProviderDelegate : class {
  
  @objc optional func providerWillChangeContent()
  
  @objc optional func providerDidChangeContent()
  
  @objc optional func providerInsertSection(index: NSIndexSet)
  
  @objc optional func providerDeleteSection(index: NSIndexSet)
  
  @objc optional func providerReloadSection(index: NSIndexSet)
  
  @objc optional func providerInsertRow(indexPath: NSIndexPath)
  
  @objc optional func providerDeleteRow(indexPath: NSIndexPath)
  
  @objc optional func providerReloadRow(indexPath: NSIndexPath)
  
  @objc optional func reloadData()
  
  @objc optional func reloadDataAndMoveToLastCell()
}
