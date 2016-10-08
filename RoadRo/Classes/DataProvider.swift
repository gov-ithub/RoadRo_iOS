//
//  DataProvider.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Response handler
public typealias DataResponseHandler = (_ result: Any?, _ errorMessage: String?) -> Void

enum ApiPath {
  case Slopes
  
  func path() -> String {
    switch self {
    case .Slopes: return "/v1/slopes"
    }
  }
}

public class DataProvider {
  
  public var dataStore : CoreDataStore = RealmStore()
  
  // APi
  var kNetworkApiURL : String
  
  // Generic error
  let kGenericError = "An error occured. Please try again later"
  
  // Api manager
  var manager : Alamofire.SessionManager!
  
  public init(apiNetworkUrl: String) {
    self.kNetworkApiURL = apiNetworkUrl
    
    // Network
    self.initNetworkManager()
  }
}
