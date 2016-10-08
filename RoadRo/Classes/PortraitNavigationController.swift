//
//  PortraitNavigationController.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class PortraitNavigationController : UINavigationController {
  override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    return .portrait
  }
}
