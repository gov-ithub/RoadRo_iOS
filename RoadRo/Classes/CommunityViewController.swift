//
//  CommunityViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {
  
  fileprivate var config: Config
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    
    self.title = NSLocalizedString("Comunitate", comment: "")
    self.tabBarItem = UITabBarItem(
      title: NSLocalizedString("Comunitate", comment: ""),
      image: UIImage(named: "communityDisabled"),
      selectedImage: UIImage(named: "communityEnabled"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = CommunityView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
