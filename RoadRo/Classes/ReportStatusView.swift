//
//  ReportStatusView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit

enum ReportStatus: Int {
  case NotProcessed
  case Processing
  case Processed
  
  var color: UIColor {
    switch self {
    case .NotProcessed: return UIColor.colorCode(234, green: 121, blue: 122, alpha: 1.0)
    case .Processing: return UIColor.colorCode(240, green: 171, blue: 51, alpha: 1.0)
    case .Processed: return UIColor.colorCode(35, green: 178, blue: 128, alpha: 1.0)
    }
  }
  
  var name: String {
    switch self {
    case .NotProcessed: return NSLocalizedString("Neprocesată", comment: "").uppercased()
    case .Processing: return NSLocalizedString("În procesare", comment: "").uppercased()
    case .Processed: return NSLocalizedString("Procesată", comment: "").uppercased()
    }
  }
}

class ReportStatusView: UILabel {
  
  var status: ReportStatus = .NotProcessed {
    didSet {
      self.backgroundColor = status.color
      self.text = status.name
    }
  }
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setup() {
    self.font = UIFont.fontAppMedium(14)
    self.textColor = UIColor.white
    self.textAlignment = .center
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      let size = super.intrinsicContentSize
      return CGSize(width: size.width + 20, height: size.height + 4)
    }
  }
}
