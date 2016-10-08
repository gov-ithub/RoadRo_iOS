//
//  Settings.swift
//  QuickWins
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation

public class Settings {

  static let userDefaults = UserDefaults.standard
  
  class public func hasValueForKey(key: String) -> Bool {
    let value = self.objectForKey(key: key)
    return value != nil
  }
  
  class public func objectForKey(key: String) -> AnyObject? {
    return self.userDefaults.object(forKey: key) as AnyObject?
  }

  class public func saveObject(value: Any!, forKey key: String) {
    self.userDefaults.set(value, forKey: key)
    self.userDefaults.synchronize()
  }

  class public func removeObjectForKey(key: String) {
    self.userDefaults.removeObject(forKey: key)
    self.userDefaults.synchronize()
  }
}
