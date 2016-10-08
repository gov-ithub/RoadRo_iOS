//
//  CoreDataStore.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Realm
import RealmSwift

public protocol CoreDataStore {
  
  var realm: Realm! { get }
  
  func clean()
}

public struct RealmStore : CoreDataStore {
  public var realm: Realm!
  
  public init() {
    let config = Realm.Configuration.defaultConfiguration
    
    do {
      self.realm = try Realm(configuration: config)
    } catch {
      print("Error: \(error)")
    }
  }
  
  public func clean() {
    try! realm.write {
      realm.deleteAll()
    }
  }
}

public struct InMemoryStore : CoreDataStore {
  public var realm: Realm!
  
  public init(name: String) {
    let config = Realm.Configuration(inMemoryIdentifier: name)
    self.realm = try! Realm(configuration: config)
  }
  
  public func clean() {
    try! realm.write {
      realm.deleteAll()
    }
  }
}
