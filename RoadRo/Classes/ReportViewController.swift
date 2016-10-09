//
//  MainViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
  
  fileprivate var config: Config
  
  var onPickImage: ((_ selection : ((_ image : UIImage?) -> Void)?) -> Void)?
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    
    self.title = NSLocalizedString("Reclamatie", comment: "")
    self.tabBarItem = UITabBarItem(
      title: NSLocalizedString("Reclamatie", comment: ""),
      image: UIImage(named: "communityDisabled"),
      selectedImage: UIImage(named: "communityEnabled"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = ReportView()
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let item = UIBarButtonItem(title: NSLocalizedString("Trimite", comment: ""), style: .plain, target: self, action: #selector(sendPressed))
    self.navigationItem.rightBarButtonItem = item
    
    // Start tracker
    do {
      try LocationTracker.instance.startTracker()
    } catch {
      DLog(object: error)
    }
  }
  
  @objc func sendPressed() {
    //    LocationTracker.instance.getLocationAddress { (address) in
    //      print(address)
    //    }

    ActivityIndicator.show()
//    onPickImage?({(image) -> Void in
//      print(image)
//      })
  }
}
