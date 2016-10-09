//
//  ReportTableViewCell.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 09/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class ReportTableViewCell: UITableViewCell {
  
  fileprivate var cardView: ReportCardView = {
    let view = ReportCardView()
    return view
  }()
  
  fileprivate var model: ReportViewModel? {
    didSet {
      if let model = self.model {
        self.cardView.configure(model: model)
      }
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.selectionStyle = .none
    
    self.addSubview(cardView)
    constrain(cardView) { view in
      view.edges == view.superview!.edges
    }
  }
  
  func configure(model: ReportViewModel) {
    self.model = model
  }
  
  static func desiredHeight(withModel model: ReportViewModel, width: CGFloat) -> CGFloat {
    if width == 0 {
      return 0
    }
    
    // Get expected height
    let height = ReportCardView.desiredHeight(forModel: model, width: width)
    return height
  }
}
