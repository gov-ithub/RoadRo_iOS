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
      image: UIImage(named: "raportDisabled"),
      selectedImage: UIImage(named: "raportEnabled"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = ReportView()
    view.onSend = {[weak self] in
      self?.sendPressed()
    }
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Start tracker
    do {
      try LocationTracker.instance.startTracker()
    } catch {
      DLog(object: error)
    }
  }
  
  fileprivate func sendPressed() {
    print("send pressed")
    //    LocationTracker.instance.getLocationAddress { (address) in
    //      print(address)
    //    }

    ActivityIndicator.show()
//    onPickImage?({(image) -> Void in
//      print(image)
//      })
  }
}
