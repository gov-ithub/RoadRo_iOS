
//
//  DataProvider+Resort.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import SwiftyJSON

extension DataProvider {
  
  @discardableResult public func doRegister(phone: String, completion: DataResponseHandler?) -> Cancelable? {
    
    let params = [ "phone": phone ]
    return self.performRequest(method: .post, path: ApiPath.Register.path(), params: params) { (result, errorMessage) -> Void in
      
      guard let result = result as? JSON else {
        completion?(nil, nil)
        return
      }
      
      guard let accessToken = result["access_token"].string, let userId = result["user_id"].string else {
          completion?(nil, errorMessage)
          return
      }
      
      completion?((accessToken: accessToken, userId: userId), errorMessage)
    }
  }
}
