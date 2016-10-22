//
//  SignupView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class SignupView: UIView {
  
  fileprivate var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.fontRegularText()
    label.text = NSLocalizedString("Please provide your phone number\nfor the account creation", comment: "")
    label.textColor = UIColor.textColorHighlighted()
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  var textField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.white
    textField.font = UIFont.fontAppLight(20)
    textField.textColor = UIColor.textColor()
    textField.keyboardType = .numberPad
    textField.returnKeyType = .send
    textField.textAlignment = .center
    
    #if DEBUG
      textField.text = "0746123456"
    #endif
    return textField
  }()
  
  fileprivate var sendView: RoundedButton = {
    let title = NSLocalizedString("Register", comment: "")
    let view = RoundedButton(title: title)
    return view
  }()

  // background scroll view needed for small screens
  private var scrollView = UIScrollView()
  
  var onSendPressed: (() -> Void)?
  
  var phoneNumber: String? {
    get {
      return self.textField.text
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
    self.backgroundColor = UIColor.white

    // Add the scroll view (will be needed for small displays like the iPad
    // iPhone compatibility layout)
    self.addSubview(scrollView)
    constrain(scrollView) { view in
      view.edges == view.superview!.edges
    }

    // Can't use both leading and trailing when laying out inside a scroll view,
    // because it won't fill the screen horizontally, so use centerX and width
    // instead.
    
    // Add photo label
    scrollView.addSubview(titleLabel)
    constrain(titleLabel) { view in
      view.top == view.superview!.top + 30
      view.centerX == view.superview!.centerX
      view.width == view.superview!.width - 40
    }
    
    // Add separator
    let separator1 = LineView()
    scrollView.addSubview(separator1)
    constrain(separator1, titleLabel) { view, topView in
      view.top == topView.bottom + 40
      view.centerX == view.superview!.centerX
      view.width == view.superview!.width
    }
    
    scrollView.addSubview(textField)
    constrain(textField, separator1) { view, topView in
      view.top == topView.bottom + 10
      view.centerX == view.superview!.centerX
      view.width == view.superview!.width - 40
      view.height == 40
    }
    
    // Add separator
    let separator2 = LineView()
    scrollView.addSubview(separator2)
    constrain(separator2, textField) { view, topView in
      view.top == topView.bottom + 10
      view.centerX == view.superview!.centerX
      view.width == view.superview!.width
    }
    
    // Add send button
    sendView.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
    scrollView.addSubview(sendView)
    constrain(sendView, separator2) { view, topView in
      view.top == topView.bottom + 40
      view.centerX == view.superview!.centerX
      // necessary for scroll view superview
      view.bottom == view.superview!.bottom - 20
    }

    self.setupKeyboardAutoLayout()
  }
  
  @objc private func sendPressed() {
    onSendPressed?()
  }

  //============================================================================
  //
  // Keyboard position notifications
  // With help from:
  // https://www.hackingwithswift.com/example-code/uikit/how-to-adjust-a-uiscrollview-to-fit-the-keyboard
  //

  //
  // Sets up keyboard notifications to resize the scroll view
  //
  private func setupKeyboardAutoLayout() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
  }

  //
  // The callback
  //
  @objc fileprivate func adjustForKeyboard(notification: Notification) {
    let userInfo = notification.userInfo!
    let screenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

    let viewEndFrame = self.convert(screenEndFrame, from: self.window)

    if notification.name == Notification.Name.UIKeyboardWillHide {
      scrollView.contentInset = UIEdgeInsets.zero
    } else {
      scrollView.contentInset = UIEdgeInsetsMake(0, 0, viewEndFrame.height, 0)
    }
    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }

}
