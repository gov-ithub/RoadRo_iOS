//
//  DataProvider+Reports.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension DataProvider {
  
  @discardableResult public func doReport(images: [UIImage], address: String, comment: String, lat: Double, long: Double, completion: DataResponseHandler?) -> Cancelable? {
    
    var imagesBase64: [String] = []
    
    for image in images {
      if let imageStr = UIImageJPEGRepresentation(image, 80)?.base64EncodedString() {
        imagesBase64.append(imageStr)
      }
    }
    
    let params: [String : Any] = [
      "images": imagesBase64,
      "address": address,
      "lat": lat,
      "long": long,
      "comment": "123"
    ]
    return self.performRequest(method: .post, path: ApiPath.Tickets.path(), params: params) { (result, errorMessage) -> Void in
      completion?(result, errorMessage)
    }
  }
}
