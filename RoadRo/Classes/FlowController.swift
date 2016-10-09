//
//  FlowController.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class FlowController : NSObject, UIGestureRecognizerDelegate {
  
  fileprivate var window: UIWindow
  fileprivate var config: Config
  
  internal var imagePicker: ImagePicker?
  var imagePickerController : UIImagePickerController?
  
  init(config: Config, window: UIWindow) {
    
    self.window = window
    self.config = config
    super.init()
    
    // Setup navigation style
    UINavigationController.applyStyle()
  }
  
  func rootController() -> UIViewController {
    var controller: UIViewController!
    if self.config.isLoggedIn {
      controller = self.createMainController()
    } else {
      controller = self.createIntroController()
    }
    return controller
  }
  
  fileprivate func resetControllers() {
    window.rootViewController = self.rootController()
  }
  
  fileprivate func createMainController() -> UIViewController {
    
    let tabController = UITabBarController()
    tabController.viewControllers = [
      self.createReportController(),
      self.createHistoryController(),
      self.createCommunityController()
    ]
    return tabController
  }
  
  fileprivate func createIntroController() -> UIViewController {
    let controller = IntroViewController()

    controller.onContinue = { [weak self] in
      self?.showSignupController(from: controller.navigationController!)
    }
    
    let navController = UINavigationController(rootViewController: controller)
    navController.isNavigationBarHidden = true
    return navController
  }
  
  func showSignupController(from navController: UINavigationController) {
    let controller = self.createSignupController()
    self.push(controller: controller, from: navController)
  }
  
  
  fileprivate func createReportController() -> UIViewController {
    let controller = ReportViewController(config: config)
    controller.onLogout = {[weak self] in
      self?.config.clearUserData()
      self?.resetControllers()
    }
    controller.onPickImage = {[weak self] (selection: ((_ image : UIImage?) -> Void)?) in
      if let controller = controller.navigationController {
        self?.showImagePicker(from: controller, withCompletion: { (image) in
          selection?(image)
        })
      }
    }
    
    let navController = PortraitNavigationController(rootViewController: controller)
    return navController
  }
  
  fileprivate func createHistoryController() -> UIViewController {
    let controller = HistoryViewController(config: config)
    let navController = UINavigationController(rootViewController: controller)
    return navController
  }
  
  fileprivate func createCommunityController() -> UIViewController {
    let controller = CommunityViewController(config: config)
    let navController = UINavigationController(rootViewController: controller)
    return navController
  }
  
  fileprivate func createSignupController() -> UIViewController {
    let controller = SignupViewController(config: config)
    controller.didSignup = {[weak self] in
      self?.resetControllers()
    }
    return controller
  }
}
