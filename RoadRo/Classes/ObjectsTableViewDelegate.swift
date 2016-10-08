//
//  ObjectsTableViewDelegate.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ObjectsTableViewDelegate<CellType: UITableViewCell> : NSObject, UITableViewDelegate, ObjectsProviderDelegate {
  
  private var rowHeights : [Int: CGFloat]!
  private let sectionExtra : Int = 10000
  
  var heightConfigurationHandler : ((_ indexPath: IndexPath, _ width: CGFloat) -> CGFloat)?
  var selectionHandler : ((_ indexPath: IndexPath) -> Void)?
  var cellConfigurationHandler : ((_ cell: CellType, _ indexPath: IndexPath) -> Void)?
  var scrollHandler: ((_ contentOffset: CGPoint) -> Void)?

  // Scrolling callbacks
  var scrollReloadDistance : CGFloat = -400
  var refreshForNextPageHandler : (() -> ())?
  
  weak var tableView : UITableView?
  
  init(tableView: UITableView, heightConfiguration: ((_ indexPath: IndexPath, _ width: CGFloat) -> CGFloat)?) {
    self.tableView = tableView
    self.rowHeights = [:]
    self.heightConfigurationHandler = heightConfiguration
    super.init()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let rowIndex = indexPath.row + sectionExtra * indexPath.section
    if let height  = rowHeights[rowIndex] {
      return height
    }
    
    let width = tableView.bounds.width
    if width == 0 {
      return 0;
    }
    
    if let height = heightConfigurationHandler?(indexPath, width) {
      // Cache height
      rowHeights[rowIndex] = height
      return height
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    selectionHandler?(indexPath)
  }
  
  //MARK: Scroll scrolling
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset;
    let bounds = scrollView.bounds;
    let size = scrollView.contentSize;
    
    let inset = scrollView.contentInset;
    let y = offset.y + bounds.size.height - inset.bottom;
    let h = size.height;
    
    // Make sure that y is at least double the screen height
    if y >= h + scrollReloadDistance && y >= scrollView.frame.height*2 {
      refreshForNextPageHandler?()
    }
    self.scrollHandler?(scrollView.contentOffset)
  }
  
  //MARK: Provider delegate
  func providerWillChangeContent() {
    self.tableView?.beginUpdates()
  }
  
  func providerDidChangeContent() {
    // Invalidate row heights
    self.rowHeights = [:]
    
    self.tableView?.endUpdates()
  }
  
  func providerInsertSection(index: NSIndexSet) {
    self.tableView?.insertSections(index as IndexSet, with: .fade)
  }
  
  func providerDeleteSection(index: NSIndexSet) {
    self.tableView?.deleteSections(index as IndexSet, with: .fade)
  }
  
  func providerReloadSection(index: NSIndexSet) {
    self.tableView?.reloadSections(index as IndexSet, with: .fade)
  }
  
  func providerInsertRow(indexPath: NSIndexPath) {
    self.tableView?.insertRows(at: [indexPath as IndexPath], with: .fade)
  }
  
  func providerDeleteRow(indexPath: NSIndexPath) {
    self.tableView?.deleteRows(at: [indexPath as IndexPath], with: .fade)
  }
  
  func providerReloadRow(indexPath: NSIndexPath) {
    if let cell = self.tableView?.cellForRow(at: indexPath as IndexPath) {
      cellConfigurationHandler?(cell as! CellType, indexPath as IndexPath)
    }
  }
  
  func reloadData() {
    // Invalidate row heights
    self.rowHeights = [:]
    
    self.tableView?.reloadData()
  }
  
  func reloadDataAndMoveToLastCell() {
    self.reloadData()
    
    if let rows = self.tableView?.numberOfRows(inSection: 0) , rows > 0 {
      let indexPath = IndexPath(row: rows-1, section: 0)
      self.tableView?.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
}
