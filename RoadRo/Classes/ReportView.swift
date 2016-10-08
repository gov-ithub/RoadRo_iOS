//
//  MainView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class ReportView: UIView {
  
  fileprivate let keyboardHandler = KeyboardHandler()

  fileprivate var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = UIColor.backgroundColor()
    return scrollView
  }()
  
  fileprivate var scrollWidthView: UIView = {
    let view = UIView()
    view.isHidden = true
    return view
  }()
  
  fileprivate var scrollViewContentWidthConstraint : NSLayoutConstraint!
  
  fileprivate var photoTitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.fontRegularText()
    label.text = NSLocalizedString("Adaugata o imagine", comment: "")
    label.textColor = UIColor.textColor()
    return label
  }()
  
  fileprivate var photoSelector: ReportPhotoSelector = {
    let view = ReportPhotoSelector()
    return view
  }()
  
  fileprivate var addressTextField: UITextField = {
    let label = UITextField()
    label.font = UIFont.fontRegularText()
    label.textColor = UIColor.textColor()
    label.placeholder = NSLocalizedString("Adresa", comment: "")
    label.backgroundColor = UIColor.white
    label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
    label.leftViewMode = .always
    label.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
    label.rightViewMode = .always
    return label
  }()
  
  fileprivate var commentsView: ReportInputView = {
    let view = ReportInputView()
    return view
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
    
    // Register handler for keyboard shown handler
    self.keyboardHandler.handler = {[weak self] height, curve, duration in
      self?.updateViewContentForKeyboard(height: height, curve: curve, duration: duration)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    
    // Scroll view
    self.addSubview(scrollView)
    constrain(scrollView) { view in
      view.edges == view.superview!.edges
    }
    
    // Add invisible view for content width
    scrollView.addSubview(scrollWidthView)
    constrain(scrollWidthView) { view in
      view.top == view.superview!.top
      view.leading == view.superview!.leading
      view.trailing == view.superview!.trailing
      self.scrollViewContentWidthConstraint = view.width == 320
    }
    
    // Add photo label
    scrollView.addSubview(photoTitleLabel)
    constrain(photoTitleLabel) { view in
      view.top == view.superview!.top + 20
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
    }
    
    // Add photo selector view
    scrollView.addSubview(photoSelector)
    constrain(photoSelector, photoTitleLabel) { view, topView in
      view.top == topView.bottom + 20
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
    }
    
    // Add address textfield
    scrollView.addSubview(addressTextField)
    constrain(addressTextField, photoSelector) { view, topView in
      view.top == topView.bottom + 20
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
      view.height == 34
    }
    
    // Add comments view
    scrollView.addSubview(commentsView)
    constrain(commentsView, addressTextField) { view, topView in
      view.top == topView.bottom + 20
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
      view.bottom == view.superview!.bottom - 20
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.scrollViewContentWidthConstraint.constant = self.bounds.width
  }
  
  private func updateViewContentForKeyboard(height: CGFloat, curve: NSInteger, duration: CGFloat) {
    let insets = UIEdgeInsetsMake(0, 0, height, 0)
    self.scrollView.contentInset = insets
    self.scrollView.scrollIndicatorInsets = insets
  }
}
