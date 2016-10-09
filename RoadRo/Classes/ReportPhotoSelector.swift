//
//  ReportPhotoSelector.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

typealias PhotoHandler = ((_ image : UIImage?) -> Void)?

protocol ReportPhotoSelectorDataSource: class {
  func pickImage(completion : PhotoHandler)
}

class ReportPhotoSelector: UIView {
  
  fileprivate var imageViews: [ReportImageSelectorView] = []
  
  var images: [UIImage] {
    get {
      var images: [UIImage] = []
      for imageView in self.imageViews {
        if let image = imageView.image {
          images.append(image)
        }
      }
      return images
    }
  }
  
  weak var dataSource: ReportPhotoSelectorDataSource?
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.backgroundGrayColor()
    
    for _ in 0..<4 {
      let view = ReportImageSelectorView()
      view.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
      self.imageViews.append(view)
      self.addSubview(view)
    }
    
    constrain(imageViews[0], imageViews[1], imageViews[2], imageViews[3]) { view1, view2, view3, view4 in
      view1.leading == view1.superview!.leading
      view4.trailing == view4.superview!.trailing
      distribute(by: 1, horizontally: view1, view2, view3, view4)
      
      view1.top == view1.superview!.top
      view1.bottom == view1.superview!.bottom
      
      view1.top == view2.top
      view2.top == view3.top
      view3.top == view4.top
      
      view1.bottom == view2.bottom
      view2.bottom == view3.bottom
      view3.bottom == view4.bottom
      
      view1.width == view2.width
      view2.width == view3.width
      view3.width == view4.width
    }
    
    self.updatePhotoSelectorViews()
  }
  
  func resetUI() {
    for imageView in self.imageViews {
      imageView.image = nil
    }
    self.updatePhotoSelectorViews()
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

extension ReportPhotoSelector {
  
  fileprivate func updatePhotoSelectorViews() {
    if let nextIndex = self.nextImageToFill() {
      for i in 0..<self.imageViews.count {
        
        let imageView = self.imageViews[i]
        imageView.isSelected = i <= nextIndex
      }
    }
  }
  
  fileprivate func appendImage(image: UIImage) {
    if let nextIndex = self.nextImageToFill() {
      let imageView = self.imageViews[nextIndex]
      imageView.image = image
    }
    self.updatePhotoSelectorViews()
  }
  
  fileprivate func nextImageToFill() -> Int? {
    for i in 0..<self.imageViews.count {
      let imageView = self.imageViews[i]
      if imageView.image == nil {
        return i
      }
    }
    return nil
  }
  
  @objc fileprivate func pickImage() {
    self.dataSource?.pickImage(completion: {[weak self] (image) in
      if let image = image {
        self?.appendImage(image: image)
      }
      })
  }
}
