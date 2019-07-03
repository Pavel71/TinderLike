//
//  CustomNavBar.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class CustomNavBar: UIView {
  
  let backButton: UIButton = {
    let b = UIButton(type: .system)
    b.setImage(#imageLiteral(resourceName: "app_icon.png").withRenderingMode(.alwaysTemplate), for: .normal)
    b.tintColor = .lightGray
    b.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
    return b
  }()
  
  let messageImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate))
    iv.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    iv.contentMode = .scaleAspectFit
    iv.tintColor = #colorLiteral(red: 1, green: 0.4225307703, blue: 0.4438772202, alpha: 1)
    return iv
  }()
  
  let messagesLabel: UILabel = {
    let label = UILabel()
    label.text = "Messages"
    label.textColor = #colorLiteral(red: 1, green: 0.4225307703, blue: 0.4438772202, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()
  
  let feedLabel: UILabel = {
    let label = UILabel()
    label.text = "Feed"
    label.textColor = .gray
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    
    let imageViewStackView = UIStackView(arrangedSubviews: [
      backButton,
      messageImageView,
      UIView()
      ])
    imageViewStackView.distribution = .equalCentering
    imageViewStackView.constrainHeight(constant: 70)
    
    
    let separatorView = UIView()
    separatorView.backgroundColor = .lightGray
    separatorView.constrainWidth(constant: 0.5)
    separatorView.alpha = 0.7
    
    let labelStackView = UIStackView(arrangedSubviews: [
      messagesLabel,
      separatorView,
      feedLabel
      ])
    labelStackView.distribution = .equalCentering
    labelStackView.layoutMargins = .init(top: 5, left: 30, bottom: 5, right:  30)
    labelStackView.isLayoutMarginsRelativeArrangement = true
    
   
    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      imageViewStackView,
      labelStackView
      ])
    
    addSubview(verticalStackView)
    verticalStackView.fillSuperview()
    
  }
  
  var didTapBackButton: EmptyClouser?
  @objc private func handleBackButton() {

    didTapBackButton!()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    layer.shadowOffset = .init(width: 0, height: 5)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.3
    layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
    
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
