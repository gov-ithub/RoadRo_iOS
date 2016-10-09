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
  var onLogout: (() -> Void)?
  
  init(config: Config) {
    self.config = config
    super.init(nibName: nil, bundle: nil)
    
    self.title = NSLocalizedString("Sesizare nouă", comment: "")
    self.tabBarItem = UITabBarItem(
      title: NSLocalizedString("Sesizare", comment: ""),
      image: UIImage(named: "raportDisabled"),
      selectedImage: UIImage(named: "raportEnabled"))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let view = ReportView()
    view.photoSelector.dataSource = self
    view.onLocateMe = {[weak self] in
      self?.locateMe()
    }
    view.onSend = {[weak self] in
      self?.sendPressed()
    }
    self.view = view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let item = UIBarButtonItem(title: "           ", style: .done, target: self, action: #selector(logoutPressed))
    self.navigationItem.leftBarButtonItem = item
    
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
      AlertView.show(withMessage: NSLocalizedString("Adaugă cel puțin o imagine", comment: ""))
      return
    }
    
    guard let address = self.contentView.address, address.characters.count > 0 else {
      AlertView.show(withMessage: NSLocalizedString("Adaugă adresa incidentului", comment: ""))
      return
    }
    let comments = self.contentView.comments ?? ""
    
    ActivityIndicator.show()
    self.config.dataProvider.doReport(images: images, address: address, comment: comments, lat: 0.0, long: 0.0) {[weak self] (_, error) in
      ActivityIndicator.hide()
      
      if let error = error {
        AlertView.show(withMessage: error)
        return
      }
      
      // Show thank you message
      AlertView.show(withMessage: "Multumim! Sesizarea ta a fost salvata.")
      
      // Reset UI
      self?.contentView.resetUI()
    }
  }
  
  fileprivate func locateMe() {
    LocationTracker.instance.getLocationAddress {[weak self] (address) in
      self?.contentView.address = address
    }
  }
  
  @objc fileprivate func logoutPressed() {
    onLogout?()
  }
}

extension ReportViewController: ReportPhotoSelectorDataSource {
  
  func pickImage(completion: PhotoHandler) {
    self.onPickImage?(completion)
  }
}
