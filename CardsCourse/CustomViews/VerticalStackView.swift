//
//  VerticalStackView.swift
//  CardsCourse
//
//  Created by PavelM on 24/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit



class VerticalStackView: UIStackView {

  
  init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
    super.init(frame: .zero)
    
    arrangedSubviews.forEach { (view) in
      addArrangedSubview(view)
    }
    
    axis = .vertical
    spacing = customSpacing
    
    
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
