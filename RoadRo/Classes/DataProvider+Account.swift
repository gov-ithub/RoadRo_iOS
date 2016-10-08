
//
//  DataProvider+Resort.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension DataProvider {
  
  @discardableResult public func doRegister(phone: String, completion: DataResponseHandler?) -> Cancelable? {
    
    return self.performRequest(method: .get, path: ApiPath.Register.path(), params: nil) { (result, errorMessage) -> Void in
      completion?(nil, nil)
    }
  }
}
