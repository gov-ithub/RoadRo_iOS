//
//  ReportPhotoSelector.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ReportPhotoSelector: UIView {
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.backgroundGrayColor()
  }
  
  override var intrinsicContentSize: CGSize {
    let height = self.bounds.width / 4
    return CGSize(width: UIViewNoIntrinsicMetric, height: height)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.invalidateIntrinsicContentSize()
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!
    let posX = floor(rect.width / 4)
    
    for i in 0..<4 {
      UIView.draw1PxLine(
        context: context,
        startPoint: CGPoint(x: posX*CGFloat(i), y: 0),
        endPoint: CGPoint(x: posX*CGFloat(i), y: rect.height),
        color: UIColor.white)
    }
  }
}
