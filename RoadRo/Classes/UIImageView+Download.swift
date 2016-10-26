//
//  UIImageView+Download.swift
//  RoadRo
//
//  Created by mihai on 26/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  func rr_setImage(url: URL, placeholder: UIImage? = nil) {
    let modifier = AnyModifier { request in
      var req = request
      req.setValue(Config.accessToken, forHTTPHeaderField: "Authorization")
      return req
    }
    
    let resource = ImageResource(downloadURL: url)
    self.kf.setImage(with: resource, placeholder: placeholder, options: [.requestModifier(modifier)])
  }
}
