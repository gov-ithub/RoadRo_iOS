//
//  ActivityIndicator.swift
//  QuickWins
//
//  Created by Mihai Dumitrache on 04/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//

import UIKit
import Cartography

class ActivityIndicator : UIView {
  static let sharedInstance = ActivityIndicator()
  
  private var activityIndicator : UIActivityIndicatorView!
  private var textLabel : UILabel!
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
    
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    let label = UILabel()
    label.textColor = UIColor.white
    label.font = UIFont.fontAppRegular(18)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.text = "text"
    label.backgroundColor = UIColor.clear
    self.textLabel = label
    
    let effect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: effect)
    self.addSubview(blurView)
    constrain(blurView) { view in
      view.edges == view.superview!.edges
    }
    
    let vibrantView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: effect))
    blurView.contentView.addSubview(vibrantView)
    constrain(vibrantView) { view in
      view.edges == view.superview!.edges
    }
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    self.activityIndicator = activityIndicator
    self.addSubview(activityIndicator)
    self.addSubview(label)
    constrain(activityIndicator, label) { view, label in
      view.centerX == view.superview!.centerX
      view.bottom == view.superview!.centerY - 20
      
      label.top == view.bottom + 16
      label.centerX == view.centerX
      label.leading == view.superview!.leading + 40
      label.trailing == view.superview!.trailing - 40
    }
  }
  
  static func show() {
    ActivityIndicator.show(message: NSLocalizedString("Se încarcă...", comment: ""))
  }
  
  static func show(message: String) {
    let indicator = ActivityIndicator.sharedInstance
    let window = UIApplication.shared.windows.first!
    indicator.frame = window.frame
    indicator.alpha = 0.0
    indicator.activityIndicator.startAnimating()
    indicator.textLabel.text = message
    window.addSubview(indicator)
    
    UIView.animate(withDuration: 0.3) {
      indicator.alpha = 1.0
    }
  }
  
  static func hide() {
    let indicator = ActivityIndicator.sharedInstance
    
    if indicator.alpha != 1.0 {
      return
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      indicator.alpha = 0.0
      indicator.activityIndicator.stopAnimating()
    }) { (_) in
      indicator.removeFromSuperview()
    }
  }
}
