//
//  RoundedButton.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class RoundedButton: UIControl {
  
  fileprivate var title: String
  
  override var isHighlighted: Bool {
    didSet {
      let alpha: CGFloat = isHighlighted ? 0.6 : 1.0
      self.textLabel.alpha = alpha
    }
  }
  
  fileprivate var textLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.white
    label.font = UIFont.fontAppMedium(20)
    label.backgroundColor = UIColor.clear
    label.textAlignment = .center
    return label
  }()
  
  init(title: String) {
    self.title = title
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  convenience init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
    self.init(title: title)
    self.backgroundColor = backgroundColor
    self.textLabel.textColor = titleColor
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.brandColor()
    self.textLabel.text = title
    self.addSubview(textLabel)
    constrain(textLabel) { view in
      view.edges == view.superview!.edges
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height/2
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      return CGSize(width: 220, height: 52)
    }
  }
}
