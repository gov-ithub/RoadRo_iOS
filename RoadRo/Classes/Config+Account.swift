//
//  Config+Account.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation

let kAccountUserId = "kAccountUserId"
let kAccountToken = "kAccountToken"

extension Config {
  
  var isLoggedIn : Bool {
    get {
      if let _ = Settings.objectForKey(key: kAccountUserId) {
        return true
      }
      return false
    }
  }
  
  func didLogin(id: String, token: String) {
    Settings.saveObject(value: id, forKey: kAccountUserId)
    Settings.saveObject(value: token, forKey: kAccountToken)
    
    // Raise login event
    self.eventAccountState.raise(data: .loggedIn)
  }
  
  func clearUserData() {
    // Remove user keys
    Settings.removeObjectForKey(key: kAccountUserId)
    Settings.removeObjectForKey(key: kAccountToken)
    
    // Raise login event
    self.eventAccountState.raise(data: .loggedOut)
  }
}
