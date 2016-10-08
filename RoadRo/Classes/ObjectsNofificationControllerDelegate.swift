//
//  ObjectsNofificationControllerDelegate.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import RealmSwift

class ObjectsNotificationControllerDelegate<T: Object> : NSObject {
  private var notification : NotificationToken? = nil
  
  var results: RealmSwift.Results<T>? {
    didSet {
      self.addNotoficationBlock()
    }
  }
  
  weak var delegate : ObjectsProviderDelegate?
  
  private func addNotoficationBlock() {
    notification = results?.addNotificationBlock({ [weak self] (changes) in
      guard let delegate = self?.delegate else { return }
      
      switch changes {
      case .initial:
        // Results are now populated and can be accessed without blocking the UI
        delegate.reloadData?()
        break
      case .update(_, let deletions, let insertions, let modifications):
        // Query results have changed, so apply them to the UITableView
        delegate.providerWillChangeContent?()
        
        let insertionsIndexPaths = insertions.map { IndexPath(row: $0, section: 0) }
        for indexPath in insertionsIndexPaths {
          delegate.providerInsertRow?(indexPath: indexPath as NSIndexPath)
        }
        
        let deletionsIndexPaths = deletions.map { IndexPath(row: $0, section: 0) }
        for indexPath in deletionsIndexPaths {
          delegate.providerDeleteRow?(indexPath: indexPath as NSIndexPath)
        }
        
        let modificationsIndexPaths = modifications.map { IndexPath(row: $0, section: 0) }
        for indexPath in modificationsIndexPaths {
          delegate.providerReloadRow?(indexPath: indexPath as NSIndexPath)
        }
        
        delegate.providerDidChangeContent?()
        break
      case .error(let error):
        // An error occurred while opening the Realm file on the background worker thread
        fatalError("\(error)")
        break
      }
      })
  }
  
  
}
