//
//  UINavigationController+App.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension UINavigationController {
  class func applyStyle() {
    let bar = UINavigationBar.appearance()
    bar.isTranslucent = true
    bar.tintColor = UIColor.white
    bar.backgroundColor = UIColor.clear
    bar.barTintColor = UIColor.clear
    bar.titleTextAttributes = [ NSFontAttributeName : UIFont.fontAppRegular(20), NSForegroundColorAttributeName: UIColor.white ]
    bar.setBackgroundImage(UIImage(), for: .default)
    bar.shadowImage = UIImage()
    
    let barItem = UIBarButtonItem.appearance()
    let attributes = [ NSFontAttributeName : UIFont.fontAppRegular(16) ]
    barItem.setTitleTextAttributes(attributes, for: UIControlState())
    
    let controler = UISegmentedControl.appearance()
    controler.tintColor = UIColor.white
    controler.backgroundColor = UIColor.black
  }
}
