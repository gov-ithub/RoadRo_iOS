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
  
  var textField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = UIColor.white
    textField.font = UIFont.fontAppRegular(16)
    textField.borderStyle = .line
    textField.keyboardType = .numberPad
    textField.returnKeyType = .send
    
    #if DEBUG
      textField.text = "0746123456"
    #endif
    return textField
  }()
  
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
    
    self.addSubview(textField)
    constrain(textField) { view in
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
      view.height == 40
      view.centerY == view.superview!.centerY
    }
    textField.becomeFirstResponder()
  }
}
