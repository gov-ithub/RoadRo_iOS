//
//  ViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

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
    super.init(nibName: nil, bundle: nil)
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.contentView.textField.becomeFirstResponder()
  }
  
  @objc fileprivate func sendPressed() {
    guard let phoneNumber = self.contentView.phoneNumber else {
      return
    }
    
    // Call register api
    self.config.dataProvider.doRegister(phone: phoneNumber) {[weak self] (_, _) in
      self?.didSignup?()
    }
  }
}

