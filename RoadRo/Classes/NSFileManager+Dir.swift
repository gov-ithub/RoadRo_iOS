//
//  NSFileManager+Dir.swift
//  SkiRomania
//
//  Created by mihai on 04/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension FileManager {
  
  class func documentsDir() -> String {
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
    return paths[0]
  }
  
  class func cachesDir() -> String {
    var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
    return paths[0]
  }
}
