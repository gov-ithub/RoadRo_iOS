//
//  IntroViewController.swift
//  RoadRo
//
//  Created by Mihai Cristescu on 09/10/16.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  
  fileprivate var contentView: IntroView { get { return self.view as! IntroView } }
  
  var onContinue: (() -> Void)?

  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = IntroView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contentView.button.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
  }
 
  @objc fileprivate func handleContinue() {
    self.onContinue?()
  }
}
