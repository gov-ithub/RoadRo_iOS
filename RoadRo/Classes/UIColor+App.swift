//
//  UIColor+App.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

extension UIColor {
  
  class func colorCode(_ red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
  }
  
  class func brandColor() -> UIColor {
    return UIColor.colorCode(111, green: 189, blue: 228, alpha: 1.0)
  }
  
  class func textColor() -> UIColor {
    return UIColor.colorCode(81, green: 81, blue: 81, alpha: 1.0)
  }
  
  class func textColorHighlighted() -> UIColor {
    return UIColor.colorCode(81, green: 81, blue: 81, alpha: 0.6)
  }
}
