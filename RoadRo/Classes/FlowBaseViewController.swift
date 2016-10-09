//
//  FlowBaseViewController.swift
//  SkiRomania
//
//  Created by Beni Pater on 23/09/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class FlowBaseViewController: UIViewController {
  
  var willAppearHandler : ((_ animated: Bool) -> Void)?
  var willDisappearHandler : ((_ animated: Bool) -> Void)?
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let handler = willAppearHandler {
      handler(animated)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let handler = willDisappearHandler {
      handler(animated)
    }
  }
}
