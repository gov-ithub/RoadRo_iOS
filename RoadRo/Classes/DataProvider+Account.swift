
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
  
  @discardableResult public func doGetResorts(dataStore: CoreDataStore, completion: DataResponseHandler?) -> Cancelable? {
    
    return self.performRequest(method: .get, path: ApiPath.Slopes.path(), params: nil) { (result, errorMessage) -> Void in
    }
  }
}
