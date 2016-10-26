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
  
  @discardableResult public func doGetMyReports(dataStore: CoreDataStore, completion: DataResponseHandler?) -> Cancelable? {
    return self.performRequest(method: .get, path: ApiPath.TicketsMine.path(), params: nil) { (result, errorMessage) -> Void in
      
      dataStore.realm.performInBackground(block: { (realm) in
        
        guard let result = result as? JSON else {
          completion?(nil, errorMessage)
          return
        }
        
        var existingItems: [String] = []
        
        if let reports = result["tickets"].array {
          for report in reports {
            
            if let dataReport = DataReport.createFromJSON(params: report, realm: realm) {
              realm.add(dataReport, update: true)
              existingItems.append(dataReport.id)
            }
          }
        }
        
        // Remove old reports
        let predicate = NSPredicate(format: "NOT id IN %@", existingItems)
        let dataToRemove = realm.objects(DataReport.self).filter(predicate)
        for data in dataToRemove {
          realm.delete(data)
        }
        
        }, completion: { 
          completion?(nil, errorMessage)
      })
    }
  }
}
