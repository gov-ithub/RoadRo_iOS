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
    bar.isTranslucent = false
    bar.tintColor = UIColor.white
    bar.titleTextAttributes = [
      NSFontAttributeName : UIFont.fontAppBold(18),
      NSForegroundColorAttributeName: UIColor.white ]
    bar.setBackgroundImage(UIImage(named: "navigationHeaderBig"), for: .default)
    
    let barItem = UIBarButtonItem.appearance()
    let attributes = [ NSFontAttributeName : UIFont.fontAppRegular(16), NSForegroundColorAttributeName: UIColor.white ]
    barItem.setTitleTextAttributes(attributes, for: UIControlState())
    
    let controler = UISegmentedControl.appearance()
    controler.tintColor = UIColor.white
    controler.backgroundColor = UIColor.black
    
    let tab = UITabBar.appearance()
    tab.tintColor = UIColor.brandColor()
  }
}
