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
      controller = self.createSignupController()
    }
    
    controller = self.createIntroController()
    return controller
  }
  
  fileprivate func resetControllers() {
    window.rootViewController = self.createMainController()
  }
  
  fileprivate func createMainController() -> UIViewController {
    
    let tabController = UITabBarController()
    tabController.viewControllers = [
      self.createReportController(),
      self.createHistoryController(),
      self.createReportController()
    ]
    return tabController
  }
  
    fileprivate func createIntroController() -> UIViewController {
        let controller = IntroViewController(config: config)
        return controller
    }
    
    
  fileprivate func createReportController() -> UIViewController {
    let controller = ReportViewController(config: config)
    let navController = UINavigationController(rootViewController: controller)
    
    controller.onPickImage = {[weak self] (selection: ((_ image : UIImage?) -> Void)?) in
      if let controller = controller.navigationController {
        self?.showImagePicker(from: controller, withCompletion: { (image) in
          selection?(image)
        })
      }
    }
    return navController
  }
  
  fileprivate func createHistoryController() -> UIViewController {
    let controller = HistoryViewController(config: config)
    let navController = UINavigationController(rootViewController: controller)
    return navController
  }
  
  fileprivate func createSignupController() -> UIViewController {
    let controller = SignupViewController(config: config)
    controller.didSignup = {[weak self] in
      self?.resetControllers()
    }
    
    let navController = UINavigationController(rootViewController: controller)
    return navController
  }
}
