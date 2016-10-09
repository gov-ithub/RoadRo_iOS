//
//  FlowController+Navigation.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension FlowController {
  
  //TODO: needs refactoring
  internal func push(controller: UIViewController, from navController: UINavigationController) {
    self.pushController(controller, navigationController: navController)
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
    
    // Setup navigation appear handlers
    if let flowBaseController = controller as? FlowBaseViewController {
      flowBaseController.willAppearHandler = {animated in
        navigationController.setNavigationBarHidden(false, animated: animated)
      }
      flowBaseController.willDisappearHandler = {animated in
        if let _ = navigationController.topViewController as? IntroViewController {
          navigationController.setNavigationBarHidden(true, animated: animated)
        }
      }
    }
    
    // Push in navigation
    navigationController.pushViewController(controller, animated: true)
    
    // Update back button
    navigationController.interactivePopGestureRecognizer?.delegate = self
  }
}
