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
  var images: [ReportImage]?
  
  var thumb: ReportImage? {
    get {
      if let image = self.images?.first {
        return image
      }
      return nil
    }
  }
  
  init(data: DataReport) {
    self.id = data.id
    self.address = data.address
    self.lat = data.lat
    self.long = data.long
    self.comments = data.comments
    self.likes = data.likes
    
    let status = ReportStatus(rawValue: data.status)
    self.status = status
    
    if let imagesData = data.images {
      if let images = NSKeyedUnarchiver.unarchiveObject(with: imagesData) as? [ReportImage] {
        self.images = images
      }
    }
  }
}
