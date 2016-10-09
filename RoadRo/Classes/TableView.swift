//
//  TableView.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 04/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//

import UIKit

class TableView : UITableView {
  
  internal var customRefreshControl : UIRefreshControl!
  private var refreshed: Bool = false
  
  var noContentView : UIView? = nil {
    didSet {
      self.backgroundView = noContentView
    }
  }
  
  var noContentFooterView : UIView? = nil {
    didSet {
      self.refreshed = false
      noContentFooterView?.isHidden = true
      self.tableFooterView = noContentFooterView
    }
  }
  
  var hasRefreshControl : Bool = true {
    didSet {
      if self.hasRefreshControl {
        self.addSubview(customRefreshControl)
      } else {
        self.customRefreshControl.removeFromSuperview()
      }
    }
  }
  
  var onNoContentViewVisibilityChanged : ((_ visible: Bool) -> ())?
  var refreshHandler : (() -> Void)? = nil
  
  override var contentSize: CGSize {
    didSet {
      self.toggleNoContentViewVisibility()
    }
  }
  
  var noContentMessage : String? {
    didSet {
      if let msgView = self.noContentView as? TableContentMessageView {
        msgView.message = noContentMessage
      }
    }
  }
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    // Temp view
    let view = TableContentMessageView()
    view.isHidden = true
    view.backgroundColor = UIColor.clear
    self.noContentView = view
    self.backgroundView = view
    
    // Refresh control
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TableView.doRefreshFromRefreshControl), for: .valueChanged)
    self.customRefreshControl = refreshControl
    self.addSubview(refreshControl)
  }
  
  @objc private func doRefreshFromRefreshControl() {
    refreshHandler?()
  }
  
  private func hasContent() -> Bool {
    var extraHeight : CGFloat = 0
    if let view = self.tableHeaderView {
      extraHeight += view.frame.height
    }
    if let view = self.tableFooterView {
      extraHeight += view.frame.height
    }
    
    if let no = self.dataSource?.tableView(self, numberOfRowsInSection: 0) , no > 0 {
      return true
    }
    return contentSize.height - extraHeight > 0
  }
  
  private func toggleNoContentViewVisibility() {
    // Hide no content view if it doesn't have content or it's refreshing
    let hideForRefreshing = !refreshed
    let hasContent = self.hasContent()
    let visibility = hasContent || hideForRefreshing
    
    if self.noContentView != nil && visibility != self.noContentView?.isHidden {
      self.noContentView?.isHidden = visibility
      onNoContentViewVisibilityChanged?(visibility)
    }
    
    if let footerView = self.noContentFooterView {
      if visibility != footerView.isHidden {
        footerView.isHidden = visibility
        footerView.sizeToFit()
        if visibility {
          self.tableFooterView = nil
        } else {
          self.tableFooterView = footerView
        }
        onNoContentViewVisibilityChanged?(visibility)
      }
    }
  }
  
  //MARK: Actions
  func beginRefreshing(animated: Bool) {
    if self.hasContent() {
      return
    }
    
    self.customRefreshControl.beginRefreshing()
    self.toggleNoContentViewVisibility()
    
    if self.contentOffset.y == 0 {
      
      let duration : TimeInterval = (animated) ? 0.25 : 0.0
      UIView.animate(withDuration: duration, animations: { 
        var contentOffset = self.contentOffset
        contentOffset.y = contentOffset.y - self.customRefreshControl.frame.height
        self.contentOffset = contentOffset
      })
    }
  }
  
  func endRefreshing(animated: Bool) {
    self.refreshed = true
    self.customRefreshControl.endRefreshing()
    self.toggleNoContentViewVisibility()
  }
}
