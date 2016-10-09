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
typealias DataResponseHandler = (_ result: Any?, _ errorMessage: String?) -> Void

protocol DataProviderAuthorizationDataSource {
  func dataProviderAccessToken() -> String?
}

enum ApiPath {
  case Register
  case Tickets
  
  func path() -> String {
    switch self {
    case .Register: return "/v0/users/register/"
    case .Tickets: return "/v0/tickets/"
    }
  }
}

class DataProvider {
  
  var dataStore : CoreDataStore = RealmStore()
  var authorizationDataSource : DataProviderAuthorizationDataSource?
  
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
