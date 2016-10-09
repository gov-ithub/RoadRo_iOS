//
//  TableContentMessageView.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 04/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//


import UIKit
import Cartography

class TableContentMessageView : UIView {
  
  private var messageLabel : UILabel!
  
  var message : String? {
    didSet {
      self.messageLabel.text = message
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    // Message view
    let label = UILabel()
    label.font = UIFont.fontAppRegular(16)
    label.textColor = UIColor.textColor()
    label.numberOfLines = 0
    label.textAlignment = .center
    self.messageLabel = label
    self.addSubview(label)
    constrain(label) { view in
      view.centerX == view.superview!.centerX ~ 750
      view.centerY == view.superview!.centerY
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20 ~ LayoutPriority(750)
    }
  }
  
  override func sizeToFit() {
    self.messageLabel.sizeToFit()
    self.frame = CGRect(x: 0, y: 0, width: 320, height: self.messageLabel.bounds.height + 20)
  }
}
