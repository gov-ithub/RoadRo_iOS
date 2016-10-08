//
//  Request+Cancelable.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import Alamofire

public protocol Cancelable : class {
  func cancel()
}

extension Request : Cancelable {
  
}
