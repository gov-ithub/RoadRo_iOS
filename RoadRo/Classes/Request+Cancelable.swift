//
//  Request+Cancelable.swift
//  SkiRomania
//
//  Created by Beni Pater on 21/09/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import Alamofire

public protocol Cancelable : class {
  func cancel()
}

extension Request : Cancelable {
  
}
