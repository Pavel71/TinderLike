//
//  SendMessageButton.swift
//  CardsCourse
//
//  Created by PavelM on 01/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class SendMessageButton: UIButton {
  
  let height: CGFloat = 50
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setTitle("Send Message", for: .normal)
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    constrainHeight(constant: height)
    layer.cornerRadius = height / 2
    
    addTarget(self, action: #selector(handleTapButton), for: .touchUpInside)
    
  }
  
  var didTapButton: EmptyClouser?
  @objc private func handleTapButton() {
    didTapButton!()
  }
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors     = [#colorLiteral(red: 0.9952067733, green: 0.1214738265, blue: 0.4448384643, alpha: 1).cgColor,#colorLiteral(red: 0.9862497449, green: 0.3882132173, blue: 0.3214219809, alpha: 1).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)

    // Помещаем его вниз!
    layer.insertSublayer(gradientLayer, at: 0)
    layer.cornerRadius = height / 2
    clipsToBounds = true
    gradientLayer.frame = rect
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
