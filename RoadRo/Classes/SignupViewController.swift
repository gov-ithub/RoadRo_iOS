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
  
  var didSignup: (() -> Void)?
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    self.title = NSLocalizedString("Signup", comment: "Signup")
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
  }
}

