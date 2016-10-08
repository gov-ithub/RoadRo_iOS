//
//  Config+Keys.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
extension Config {
  struct Urls {
    private static var kNetworkApiUrlStaging = ""
    
    // Api url
    static let kNetworkApiUrl : String = {
      return kNetworkApiUrlStaging
    }()
  }
  
  struct Keys {
    static let kApplicationDidEnterForeground = "kApplicationDidEnterForeground"
  }
}
