//
//  FlowController+Navigation.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension FlowController {
  
  internal func pushController(_ controller: UIViewController) {
    if let currentNavController = self.currentNavigationController {
      self.pushController(controller, navigationController: currentNavController)
    }
  }
  
  internal func popController(_ animated: Bool) {
    if let currentNavController = self.currentNavigationController {
      currentNavController.popViewController(animated: animated)
    }
  }
  
  internal func presentController(_ controller: UIViewController) {
    self.currentNavigationController?.present(controller, animated: true, completion: nil)
  }
  
  internal func dismissController(_ animated: Bool) {
    if let currentNavController = self.currentNavigationController {
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
  
  @objc fileprivate func dismissViewController() {
    self.currentNavigationController?.dismiss(animated: true, completion: nil)
  }
}
