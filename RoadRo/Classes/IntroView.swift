//
//  IntroView.swift
//  RoadRo
//
//  Created by Mihai Cristescu on 09/10/16.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import UIKit
import Cartography

class IntroView: UIView {
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let logoView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "logoGov"))
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "RoadRo"
    label.font = UIFont.boldSystemFont(ofSize: 37)
    label.textColor = UIColor.white
    return label
  }()
  
  let textlabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 3
    label.textColor = UIColor.white
    label.font = UIFont.fontAppRegular(15)
    label.textAlignment = .center
    label.text = NSLocalizedString("Bine ai venit! Aplicația te va ajuta să trimiți sesizări în mod direct pentru parcările ilegale pe care le observi.",
                                   comment: "Descriere aplicațsie")
    return label
  } ()
  
  let button: RoundedButton = {
    let title = NSLocalizedString("Continuă", comment: "Titlu buton")
    let button = RoundedButton(title: title, titleColor: UIColor.brandColor() , backgroundColor: .white)
    return button
  }()
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.brandColor()
    self.addSubview(logoView)
    self.addSubview(titleLabel)
    self.addSubview(textlabel)
    self.addSubview(button)
    
    constrain(logoView, titleLabel, textlabel, button) { (logo, title, text, button) in
      
      // logo position
      logo.centerX == logo.superview!.centerX
      logo.top == logo.superview!.top + 75
      logo.width == 80
      logo.height == 80
      
      // title positions
      title.centerX == title.superview!.centerX
      title.top == logo.bottom + 50
      
      // description position
      text.centerX == text.superview!.centerX
      text.width == 285
      text.top == title.bottom + 35
      
      // button position
      button.centerX == button.superview!.centerX
      button.bottom == button.superview!.bottom - 125
      button.height == 50
      button.width == 220
      
    }
    
    
    
  }
}

