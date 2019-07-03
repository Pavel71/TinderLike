//
//  CustomTextField.swift
//  CardsCourse
//
//  Created by PavelM on 13/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
  
  let padding: CGFloat
  
  init(padding: CGFloat) {
    self.padding = padding
    super.init(frame: .zero)
    
    layer.cornerRadius = 25
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Метод отвечает за гранизыц печати в текстФилде
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override var intrinsicContentSize: CGSize {
    return .init(width: 0, height: 50)
  }
  
}


