//
//  LineView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class LineView: UIView {
  
  init() {
    super.init(frame: CGRect.zero)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.setNeedsDisplay()
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      return CGSize(width: UIViewNoIntrinsicMetric, height: 1)
    }
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!
    UIView.draw1PxLine(
      context: context,
      startPoint: CGPoint(x: 0, y: 0),
      endPoint: CGPoint(x: rect.width, y: 0),
      color: UIColor.separatorColor())
  }
}
