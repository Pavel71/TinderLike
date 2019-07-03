//
//  SettingsView.swift
//  CardsCourse
//
//  Created by PavelM on 17/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class HeaderView: UIView {
  
  
  
  
  lazy var image1Button = createButton(selector: #selector(handleSelectPhotoButton))
  lazy var image2Button = createButton(selector: #selector(handleSelectPhotoButton))
  lazy var image3Button = createButton(selector: #selector(handleSelectPhotoButton))
  
  
  
  func createButton(selector: Selector) -> UIButton {
    
    let b = UIButton(type: .system)
    b.setTitle("Select Photo", for: .normal)
    b.backgroundColor = .white
    
    b.imageView?.contentMode = .scaleAspectFill
    b.clipsToBounds = true
    b.layer.cornerRadius = 8
    
    b.addTarget(self, action: selector, for: .touchUpInside)
    return b
  }
  
  func getImageButtons() -> [UIButton] {
    
    return [image1Button,image2Button,image3Button]
  }
  
  var handleSelectPhotoClouser: ((UIButton) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
   setLayout()
   setTagButton()
  }
  
  @objc private func handleSelectPhotoButton(button: UIButton) {
    handleSelectPhotoClouser?(button)
  }
  
  private func setTagButton() {
    image1Button.tag = 0
    image2Button.tag = 1
    image3Button.tag = 2
  }
  
  private func setLayout() {
    let padding: CGFloat = 16
    
    let stackView = UIStackView(arrangedSubviews: [
      image2Button,
      image3Button
      ])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 5
    
    addSubview(image1Button)
    image1Button.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,padding: .init(top: padding, left: padding, bottom: padding, right: 0))
    image1Button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
    
    addSubview(stackView)
    stackView.anchor(top: topAnchor, leading: image1Button.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: padding, left: padding, bottom: padding, right: padding))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
