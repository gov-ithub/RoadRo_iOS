//
//  ReportViewModel.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation

class ReportViewModel: NSObject {
  
  var id: String!
  var address: String?
  var lat: Double
  var long: Double
  var comments: String?
  var likes: Int = 0
  var status: ReportStatus!
  
  init(data: DataReport) {
    self.id = data.id
    self.address = data.address
    self.lat = data.lat
    self.long = data.long
    self.comments = data.comments
    self.likes = data.likes
    
    let status = ReportStatus(rawValue: data.status)
    self.status = status
  }
}
