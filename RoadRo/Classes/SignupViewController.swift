//
//  ViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class SignupViewController: FlowBaseViewController {
  
  fileprivate var contentView: SignupView { get { return self.view as! SignupView } }
  fileprivate var config: Config
  
  fileprivate var sendButton: UIBarButtonItem = {
    let item = UIBarButtonItem(
      title: NSLocalizedString("Trimite", comment: "Trimite"),
      style: .done,
      target: self,
      action: #selector(sendPressed))
    return item
  }()
  
  var didSignup: (() -> Void)?
  
  init(config: Config) {
    self.config = config
    super.init()
    self.title = NSLocalizedString("Inregistrare", comment: "Inregistrare")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = SignupView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = sendButton
    self.navigationItem.hidesBackButton = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.contentView.textField.becomeFirstResponder()
  }
  
  @objc fileprivate func sendPressed() {
    guard let phoneNumber = self.contentView.phoneNumber else {
      return
    }
    
    // Call register api
    ActivityIndicator.show()
    self.config.dataProvider.doRegister(phone: phoneNumber) {[weak self] (result, error) in
      ActivityIndicator.hide()
      
      if let error = error {
        AlertView.show(withMessage: error)
        return
      }
      
      guard let result = result as? (accessToken: String, userId: String) else {
        return
      }
      
      self?.config.didLogin(id: result.userId, token: result.accessToken)
      self?.didSignup?()
    }
  }
}

