//
//  CardViewModel.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


protocol ProducesCardViewModel {
  func toCardViewModel() -> CardViewModel
}

class CardViewModel {
  
  let uid: String
  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment
  
  init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment,uid: String ) {
    
    self.imageNames = imageNames
    self.attributedString = attributedString
    self.textAlignment = textAlignment
    self.uid = uid
  }
  
}
