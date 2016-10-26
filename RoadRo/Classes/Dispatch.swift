//
//  DataFileModel.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import RealmSwift

public struct Dispatch {
  
  public static func performInBackground(block: @escaping (() -> Void), completion: (() -> Void)?) {
    DispatchQueue.global(qos: .default).async {
      // Perform block
      block()
      
      DispatchQueue.main.async {
        // Call completion on main thread
        completion?()
      }
    }
  }
}

extension Realm {
  
  public func performInBackground(block: @escaping ((_ realm: Realm) -> Void), completion: (() -> Void)?) {
    
    let configuration = self.configuration
    DispatchQueue.global(qos: .default).async {
      // Perform block
      let blockRealm = try! Realm(configuration: configuration)
      blockRealm.beginWrite()
      
      block(blockRealm)
      
      try! blockRealm.commitWrite()
      
      DispatchQueue.main.async {
        // Refresh current realm
        self.refresh()
        
        // Call completion on main thread
        completion?()
      }
    }
  }
}
