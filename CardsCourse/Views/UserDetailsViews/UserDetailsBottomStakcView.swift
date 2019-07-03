//
//  MainBottomStackView.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class UserDetailsBottomStackView: UIStackView {
  
  
  static func createButton(image: UIImage) -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    return button
  }
  
  
  let dismissButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
  let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
  let starButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    [dismissButton,starButton,likeButton,].forEach { (button) in
      addArrangedSubview(button)
    }
    
    distribution = .fillEqually
    constrainHeight(constant: 100)
    
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
