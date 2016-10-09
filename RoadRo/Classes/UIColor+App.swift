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
    return UIColor.colorCode(29, green: 175, blue: 236, alpha: 1.0)
  }
  
  class func backgroundColor() -> UIColor {
    return UIColor.colorCode(236, green: 237, blue: 238, alpha: 1.0)
  }
  
  class func backgroundGrayColor() -> UIColor {
    return UIColor.colorCode(242, green: 244, blue: 246, alpha: 1.0)
  }
  
  class func textColor() -> UIColor {
    return UIColor.colorCode(95, green: 95, blue: 95, alpha: 1.0)
  }
  
  class func textColorHighlighted() -> UIColor {
    return UIColor.colorCode(0, green: 114, blue: 185, alpha: 1.0)
  }
  
  class func separatorColor() -> UIColor {
    return UIColor.colorCode(216, green: 216, blue: 216, alpha: 0.6)
  }
}
