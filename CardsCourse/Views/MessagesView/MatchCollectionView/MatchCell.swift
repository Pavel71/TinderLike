//
//  MatchCell.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class MatchCell: UICollectionViewCell {
  
  
  
  var item: Match! {
    didSet {
      guard let url = URL(string: item.profileImageUrl) else {return}
      imageView.sd_setImage(with: url)
      nameLabel.text = item.name
    }
  }
  
  let heightImage: CGFloat = 80
  
  let imageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "kelly2"))
    iv.contentMode = .scaleAspectFill
//    iv.layer.cornerRadius = 25
//    iv.clipsToBounds = true
    return iv
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Mark Popkovich"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.numberOfLines = 2
    return label
  }()
  
  // Здесь будут ячейки Нужна фотка и Label
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.constrainWidth(constant: heightImage)
    imageView.constrainHeight(constant: heightImage)
    imageView.layer.cornerRadius = heightImage / 2
    imageView.clipsToBounds = true

    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      imageView,
      nameLabel
      ])
    verticalStackView.distribution = .fill
    verticalStackView.alignment = .center
    
    addSubview(verticalStackView)
    verticalStackView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
