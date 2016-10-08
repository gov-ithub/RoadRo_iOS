//
//  CellConfigurator.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Foundation
import UIKit

protocol Updatable: class {
  
  associatedtype ViewData
  
  func updateWithViewData(viewData: ViewData)
  
  static func desiredHeightWithViewData(viewData: ViewData, width: CGFloat) -> CGFloat
}

class ConfiguredCell: UITableViewCell {
  
  func configure(object: Any, width: CGFloat) {
  }
  
  class func desiredHeight(withModel: Any, width: CGFloat) -> CGFloat {
    return 0
  }
}

protocol CellConfiguratorType {
  
  var reuseIdentifier: String { get }
  var cellClass: AnyClass { get }
  
  func updateCell(cell: UITableViewCell)
  func desiredHeight(width: CGFloat) -> CGFloat
  func data() -> Any?
}

struct CellConfigurator<Cell> where Cell: Updatable, Cell: UITableViewCell {
  
  let viewData: Cell.ViewData
  let reuseIdentifier: String = NSStringFromClass(Cell.self)
  let cellClass: AnyClass = Cell.self
  
  func desiredHeight(width: CGFloat) -> CGFloat {
    return Cell.desiredHeightWithViewData(viewData: viewData, width: width)
  }
  
  func updateCell(cell: UITableViewCell) {
    if let cell = cell as? Cell {
      cell.updateWithViewData(viewData: viewData)
    }
  }
  
  func data() -> Any? {
    return viewData
  }
}

extension CellConfigurator: CellConfiguratorType {
}
