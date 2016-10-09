//
//  UIImage+Resizing.swift
//  QuickWins
//
//  Created by Mihai Dumitrache on 09/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//

import UIKit

extension UIImage {
  
  func imageByScaling(toSize targetSize: CGSize) -> UIImage? {
    
    let sourceImage : UIImage? = self
    var newImage : UIImage? = nil
    
    let targetWidth = targetSize.width
    let targetHeight = targetSize.height
    
    let scaledWidth = targetWidth
    let scaledHeight = targetHeight
    
    let thumbnailPoint = CGPoint(x:0.0, y: 0.0)
    
    UIGraphicsBeginImageContext(targetSize);
    
    var thumbnailRect = CGRect.zero
    thumbnailRect.origin = thumbnailPoint
    thumbnailRect.size.width  = scaledWidth
    thumbnailRect.size.height = scaledHeight
    sourceImage?.draw(in: thumbnailRect)
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
  }
}
