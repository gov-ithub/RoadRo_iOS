//
//  MainViewController.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
  
  fileprivate var contentView: ReportView { get { return self.view as! ReportView } }
  fileprivate var config: Config
  
  var onPickImage: ((_ selection : PhotoHandler) -> Void)?
  
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
    view.photoSelector.dataSource = self
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
    self.view.endEditing(true)
    
    let images = self.contentView.images
    if images.count == 0 {
      AlertView.show(withMessage: NSLocalizedString("Adauga cel putin o imagine", comment: ""))
      return
    }
    
    guard let address = self.contentView.address, address.characters.count > 0 else {
      AlertView.show(withMessage: NSLocalizedString("Adauga adresa incidentului", comment: ""))
      return
    }
  }
}

extension ReportViewController: ReportPhotoSelectorDataSource {
  
  func pickImage(completion: PhotoHandler) {
    self.onPickImage?(completion)
  }
}
