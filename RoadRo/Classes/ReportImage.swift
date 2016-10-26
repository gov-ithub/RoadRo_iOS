//
//  DataFileModel.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation

class ReportImage: NSObject, NSCoding {
  
  var originalUrl: String
  var thumbUrl: String
  
  init(original: String, thumb: String) {
    self.originalUrl = original
    self.thumbUrl = thumb
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(originalUrl, forKey: "original")
    aCoder.encode(thumbUrl, forKey: "thumb")
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.originalUrl = aDecoder.decodeObject(forKey: "original") as! String
    self.thumbUrl = aDecoder.decodeObject(forKey: "thumb") as! String
    super.init()
  }
}
