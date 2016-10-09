//
//  ReportInputView.swift
//  RoadRo
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class ReportInputView: UIView {
  
  fileprivate var textView: UITextView = {
    let textView = UITextView()
    textView.textColor = UIColor.textColor()
    textView.font = UIFont.fontTitleText()
    textView.contentMode = .top
    textView.showsHorizontalScrollIndicator = false
    textView.layer.cornerRadius = 4
    textView.textContainerInset = UIEdgeInsets.zero
    textView.textContainer.lineFragmentPadding = 0
    textView.autocapitalizationType = .sentences
    textView.isScrollEnabled = false
    return textView
  }()
  
  fileprivate var placeholder: UILabel = {
    let placeholder = UILabel()
    placeholder.textColor = UIColor.colorCode(199, green: 199, blue: 199, alpha: 1.0)
    placeholder.font = UIFont.fontTitleText()
    placeholder.text = NSLocalizedString("Observații", comment: "")
    return placeholder
  }()
  
  var text: String {
    get {
      return textView.text
    }
    set {
      self.textView.text = newValue
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
    self.backgroundColor = UIColor.white
    textView.delegate = self
    
    self.addSubview(textView)
    constrain(textView) { view in
      view.top == view.superview!.top + 10
      view.leading == view.superview!.leading + 20
      view.trailing == view.superview!.trailing - 20
    }
    
    self.addSubview(placeholder)
    constrain(placeholder, textView) { view, textView in
      view.leading == textView.leading
      view.top == textView.top
      view.trailing == textView.trailing
    }
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      let contentSize = self.textView.sizeThatFits(CGSize(width: self.bounds.width - 20, height: CGFloat.infinity))
      let height = contentSize.height + 20
      return CGSize(width: UIViewNoIntrinsicMetric, height: max(100, height))
    }
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!
    UIView.draw1PxLine(
      context: context,
      startPoint: CGPoint(x: 0, y: rect.height-1),
      endPoint: CGPoint(x: rect.width, y: rect.height-1),
      color: UIColor.separatorColor())
  }
}

extension ReportInputView: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    self.invalidateIntrinsicContentSize()
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    self.placeholder.isHidden = true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    self.placeholder.isHidden = textView.text.characters.count != 0
  }
}
