//
//  ReportImageSelectorView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class ReportImageSelectorView: UIControl {
  
  fileprivate var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "photoPlaceholder")
    imageView.highlightedImage = UIImage(named: "photo")
    imageView.contentMode = .center
    return imageView
  }()
  
  fileprivate var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.isHidden = true
    return imageView
  }()
  
  override var isHighlighted: Bool {
    didSet {
      let alpha: CGFloat = isHighlighted ? 0.6 : 1.0
      self.iconImageView.alpha = alpha
    }
  }
  
  override var isSelected: Bool {
    didSet {
      self.iconImageView.isHighlighted = isSelected
      self.isUserInteractionEnabled = isSelected
      
      if isSelected {
        self.backgroundColor = UIColor.brandColor()
      } else {
        self.backgroundColor = UIColor.clear
      }
    }
  }
  
  var image: UIImage? {
    didSet {
      self.imageView.image = image
      self.imageView.isHidden = false
    }
  }
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.autoresizesSubviews = false
    
    self.addSubview(iconImageView)
    constrain(iconImageView) { view in
      view.edges == view.superview!.edges
    }
    
    self.addSubview(imageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView.frame = self.bounds
  }
}
