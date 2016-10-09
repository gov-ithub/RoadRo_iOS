//
//  ReportCardView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import Cartography

class ReportCardView: UIView {
  
  fileprivate var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = UIColor.backgroundGrayColor()
    imageView.image = UIImage(named: "photoPlaceholder")
    imageView.contentMode = .center
    return imageView
  }()
  
  fileprivate var timeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.fontAppLight(14)
    label.text = "19 Septembrie 2016"
    label.textColor = UIColor.textColor()
    return label
  }()
  
  fileprivate var addressLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.fontAppRegular(16)
    label.text = "str. Constantin Brancusi, nr. 12"
    label.textColor = UIColor.textColor()
    return label
  }()
  
  fileprivate var statusView: ReportStatusView = {
    let view = ReportStatusView()
    return view
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    self.backgroundColor = UIColor.white
    
    self.addSubview(imageView)
    constrain(imageView) { view in
      view.top == view.superview!.top + 16
      view.leading == view.superview!.leading + 16
      view.width == 70
      view.height == 70
      view.bottom == view.superview!.bottom - 16
    }
    
    self.addSubview(timeLabel)
    constrain(timeLabel, imageView) { view, imageView in
      view.top == imageView.top
      view.leading == imageView.trailing + 16
      view.trailing == view.superview!.trailing - 16
    }
    
    self.addSubview(addressLabel)
    constrain(addressLabel, timeLabel) { view, topView in
      view.top == topView.bottom + 6
      view.leading == topView.leading
      view.trailing == topView.trailing
    }
    
    self.addSubview(statusView)
    constrain(statusView, imageView) { view, leftView in
      view.bottom == leftView.bottom
      view.leading == leftView.trailing + 16
    }
  }
  
  func configure(model: ReportViewModel) {
    self.statusView.status = model.status
  }
  
  static let genericCardView = ReportCardView()
  
  static func desiredHeight(forModel model: ReportViewModel, width: CGFloat) -> CGFloat {
    if width == 0 {
      return 0
    }
    
    let cardView = ReportCardView.genericCardView
    cardView.configure(model: model)
    cardView.frame = CGRect(x: 0, y: 0, width: width, height: 1000)
    cardView.setNeedsLayout()
    cardView.layoutIfNeeded()
    
    let size = cardView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    return CGFloat(ceil(size.height))
  }
}
