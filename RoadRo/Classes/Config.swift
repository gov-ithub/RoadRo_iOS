//
//  Config.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Reachability

enum AccountState : Int {
  case loggedIn
  case loggedOut
}

class Config {
  
  var reachability = NetworkReachability()
  
  // Api data provider
  lazy var dataProvider : DataProvider = {
    let dataProvider = DataProvider(apiNetworkUrl: Config.Urls.kNetworkApiUrl)
    return dataProvider
  }()
  
  // Handler for account state changed
  var eventAccountState = Event<AccountState>()
  
  init() {
  }
}

