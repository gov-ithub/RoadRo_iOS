//
//  FlowController+Navigation.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension FlowController {
  
  internal func push(controller: UIViewController) {
    if let currentNavController = controller.navigationController {
      self.pushController(controller, navigationController: currentNavController)
    }
  }
  
  internal func pop(controller: UIViewController, animated: Bool) {
    if let currentNavController = controller.navigationController {
      currentNavController.popViewController(animated: animated)
    }
  }
  
  internal func present(controller: UIViewController, from: UIViewController) {
    from.navigationController?.present(controller, animated: true, completion: nil)
  }
  
  internal func dismiss(controller:UIViewController, animated: Bool) {
    if let currentNavController = controller.navigationController {
      currentNavController.dismiss(animated: animated, completion: nil)
    }
  }
  
  //MARK: Navigation
  fileprivate func pushController(_ controller: UIViewController, navigationController: UINavigationController) {
    
    // Push in navigation
    navigationController.pushViewController(controller, animated: true)
    
    // Update back button
    navigationController.interactivePopGestureRecognizer?.delegate = self
  }
}
