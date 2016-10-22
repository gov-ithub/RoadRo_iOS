//
//  Config+Keys.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
extension Config {
  struct Urls {
    private static var kNetworkApiUrlStaging = "http://193.230.8.35:23023/api"
    
    // Api url
    static let kNetworkApiUrl : String = {
      return kNetworkApiUrlStaging
    }()
  }
  
  struct Keys {
    static let kApplicationDidEnterForeground = "kApplicationDidEnterForeground"
  }
}
