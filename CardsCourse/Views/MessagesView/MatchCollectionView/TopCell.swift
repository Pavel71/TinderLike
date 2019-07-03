//
//  MatchCell.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class TopCell: UICollectionViewCell {
  
  // Можно сюда тупо Label хэдер добавить и не парится
  
  let horizintalController = MatchHorizontalController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(horizintalController.view)
    horizintalController.view.fillSuperview()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
