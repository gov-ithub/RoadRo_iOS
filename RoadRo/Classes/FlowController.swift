//
//  FlowController.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class FlowController : NSObject, UIGestureRecognizerDelegate {
  var window: UIWindow
  var config: Config
  
  fileprivate lazy var mainNavigationController : UINavigationController = PortraitNavigationController()
  
  var currentNavigationController : UINavigationController?
  
  init(config: Config, window: UIWindow) {
    self.window = window
    self.config = config
    super.init()
    
    // Setup navigation style
    UINavigationController.applyStyle()
  }
  
  func rootController() -> UIViewController {
    let navController : UINavigationController = self.mainNavigationController
    
    var controller: UIViewController!
    if self.config.isLoggedIn {
      controller = self.createMainController()
    } else {
      controller = self.createSignupController()
    }
    navController.viewControllers = [ controller ]
    navController.automaticallyAdjustsScrollViewInsets = false
    
    self.currentNavigationController = navController
    return navController
  }
  
  fileprivate func resetControllers() {
    window.rootViewController = self.createMainController()
  }
  
  fileprivate func createMainController() -> UIViewController {
    
    let tabController = UITabBarController()
    tabController.viewControllers = [
      self.createReportController(),
      self.createReportController(),
      self.createReportController()
    ]
    
    return tabController
  }
  
  fileprivate func createReportController() -> ReportViewController {
    let viewController = ReportViewController(config: config)
    return viewController
  }
  
  fileprivate func createSignupController() -> SignupViewController {
    let controller = SignupViewController(config: config)
    controller.didSignup = {[weak self] in
      self?.resetControllers()
    }
    return controller
  }
}
