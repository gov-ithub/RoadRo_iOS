//
//  DataReport.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class DataReport: Object {
  
  dynamic public var id: String! = ""
  dynamic public var address: String?
  dynamic public var lat: Double = 0.0
  dynamic public var long: Double = 0.0
  dynamic public var comments: String?
  dynamic public var likes: Int = 0
  dynamic public var status: Int = 0
  
  class func createFromJSON(params: JSON, realm: Realm) -> DataReport? {
    guard let id = params["id"].string else {
      return nil
    }
    
    var object = realm.object(ofType: DataReport.self, forPrimaryKey: id)
    if object == nil {
      object = DataReport()
      object?.id = id
    }
    
    object?.fill(params: params, realm: realm)
    return object
  }
  
  fileprivate func fill(params: JSON, realm: Realm) {
    self.address = params["address"].string
    self.lat = params["lat"].double ?? 0
    self.long = params["long"].double ?? 0
    self.comments = params["comments"].string
    self.likes = params["likes"].int ?? 0
  }
  
  override public static func primaryKey() -> String {
    return "id"
  }
  
  func viewModel() -> ReportViewModel {
    return ReportViewModel(data: self)
  }
}
