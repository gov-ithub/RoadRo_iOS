//
//  ReportViewModel.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation

public class ReportViewModel: NSObject {
  
  public var id: String!
  public var address: String?
  public var lat: Double
  public var long: Double
  public var comments: String?
  public var likes: Int = 0
  
  public init(data: DataReport) {
    self.id = data.id
    self.address = data.address
    self.lat = data.lat
    self.long = data.long
    self.comments = data.comments
    self.likes = data.likes
  }
}
