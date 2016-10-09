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
    label.text = NSLocalizedString("Introduceți numărul de telefon pentru\ncrearea unui cont", comment: "")
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
    let title = NSLocalizedString("Înregistrare", comment: "")
    let view = RoundedButton(title: title)
    return view
  }()
  
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
    
    // Add photo label
    self.addSubview(titleLabel)
    constrain(titleLabel) { view in
      view.top == view.superview!.top + 30
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
    }
    
    // Add separator
    let separator1 = LineView()
    self.addSubview(separator1)
    constrain(separator1, titleLabel) { view, topView in
      view.top == topView.bottom + 40
      view.leading == view.superview!.leading
      view.trailing == view.superview!.trailing
    }
    
    self.addSubview(textField)
    constrain(textField, separator1) { view, topView in
      view.top == topView.bottom + 10
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
      view.height == 40
    }
    
    // Add separator
    let separator2 = LineView()
    self.addSubview(separator2)
    constrain(separator2, textField) { view, topView in
      view.top == topView.bottom + 10
      view.leading == view.superview!.leading
      view.trailing == view.superview!.trailing
    }
    
    // Add send button
    sendView.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
    self.addSubview(sendView)
    constrain(sendView, separator2) { view, topView in
      view.top == topView.bottom + 40
      view.centerX == view.superview!.centerX
    }
  }
  
  @objc private func sendPressed() {
    onSendPressed?()
  }
}
