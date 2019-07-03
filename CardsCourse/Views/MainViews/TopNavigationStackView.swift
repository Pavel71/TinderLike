//
//  TopNavigationStackView.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
  
  let settingsButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
  


  override init(frame: CGRect) {
    super.init(frame: frame)
    
    fireImageView.contentMode = .scaleAspectFit
    
    configureSettingButton()
    
    configureMessageButton()
    
   
    
    [settingsButton, fireImageView, messageButton].forEach { (view) in
      addArrangedSubview(view)
    }
    
    distribution = .equalCentering
    constrainHeight(constant: 80)
    
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
    
    
  }
  private func configureMessageButton() {
     messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
    messageButton.addTarget(self, action: #selector(handleTapMesssageButton), for: .touchUpInside)
  }

  private func configureSettingButton() {
    settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
    settingsButton.addTarget(self, action: #selector(handleSettingsButton), for: .touchUpInside)
  }
  var didTapMessageButton: EmptyClouser?
  @objc private func handleTapMesssageButton() {
    didTapMessageButton!()
  }
  
  var handleSettingsButtonClouser: (() -> Void)?
  @objc private func handleSettingsButton() {
    
    handleSettingsButtonClouser?()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
