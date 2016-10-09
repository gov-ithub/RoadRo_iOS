//
//  AlertView.swift
//  QuickWins
//
//  Created by Mihai Dumitrache on 05/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//

import UIKit

class AlertView {
  
  static func alert(withMessage message: String, completion: (() -> ())?) -> UIAlertController {
    
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion?()
    })
    alert.addAction(action)
    return alert
  }
  
  static func show(withMessage message: String) {
    return show(withMessage: message, completion: nil)
  }
  
  static func show(withMessage message: String, completion: (() ->())?) {
    let alert = self.alert(withMessage: message, completion: completion)
    alert.presentFromMainWindow(animated: true, completion: nil)
  }
  
  static func show(withMessage message: String, fromController controller: UIViewController) {
    let alert = self.alert(withMessage: message, completion: nil)
    controller.present(alert, animated: true, completion: nil)
  }
}
