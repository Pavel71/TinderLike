//
//  Advertiser.swift
//  CardsCourse
//
//  Created by PavelM on 13/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
  
  let title: String
  let brandName: String
  let posterPhotoName: String
  
  
  func toCardViewModel() -> CardViewModel {
    
    let attributeString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
    
    attributeString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
    
    // UIImage Заглушка!
    return CardViewModel(imageNames: [posterPhotoName], attributedString: attributeString, textAlignment: .center,uid: "")
  }
}
