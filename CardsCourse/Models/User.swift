//
//  User.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
  
  var name: String?
  var age: Int?
  var profession: String?

  let userID: String?
  
  var imageURlArray:[String]?
  
  var minSeekingAge: Int?
  var maxSeekingAge: Int?
  
  init(dictionary: [String: Any]) {
    
    self.age = dictionary[UserKey.age.rawValue] as? Int
    self.profession = dictionary[UserKey.profession.rawValue] as? String
    
    self.name = dictionary[UserKey.name.rawValue] as? String ?? ""
    self.imageURlArray = dictionary[UserKey.imageArray.rawValue] as? [String] ?? ["","",""]
    self.userID = dictionary[UserKey.userId.rawValue] as? String ?? ""
    self.minSeekingAge = dictionary[UserKey.minSeekingAge.rawValue] as? Int
    self.maxSeekingAge = dictionary[UserKey.maxSeekingAge.rawValue] as? Int
    
    
  }
  
  func toCardViewModel() -> CardViewModel {
    
    let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    
    let ageString = age != nil ? "\(age!)": "N\\A"
    let professionString = profession != nil ? profession! : "Not available"
    
    attributedText.append(NSAttributedString(string: "  \(ageString)" , attributes: [.font: UIFont.systemFont(ofSize: 24 , weight: .regular)]))
    
    attributedText.append(NSAttributedString(string: "\n\(professionString)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))

    return CardViewModel(imageNames: imageURlArray ?? ["","",""], attributedString: attributedText, textAlignment: .left,uid: userID ?? "")
  }
  
}


