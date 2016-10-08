//
//  FlowController+ImagePicker.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import UIKit

extension FlowController {
  
  func showImagePicker(from controller: UIViewController, withCompletion completion:@escaping ((_ image: UIImage?) -> Void)) {
    self.imagePicker = ImagePicker(withCompletion: {[unowned self] (image) -> Void in
      completion(image)
      self.imagePicker = nil
      })
    imagePicker?.showFromController(viewController: controller)
  }
}
