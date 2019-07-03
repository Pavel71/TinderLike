//
//  CustomButton.swift
//  CardsCourse
//
//  Created by PavelM on 28/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
  
  
  // В общем я разобрался осталось только протестировать это как будут работаь таргеты!
  
  // Если использовать convinience то мы получим доступ к  cjnvinencam super class
  // Так как без Store Property мы автоматически получаем все инициализаторы Super Classa
  
  let height: CGFloat = 50

  
  convenience init(title: String,titleColor: UIColor, controlState: UIControl.State) {
    self.init(type: .system)

    setTitle(title, for: .normal)
    setTitleColor(titleColor,for: controlState)
    titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    constrainHeight(constant: height)
    layer.cornerRadius = height / 2
    
    addTarget(self, action: #selector(handleTapButton), for: .touchUpInside)
    
  }
  
  var didTapButton: EmptyClouser?
  @objc private func handleTapButton() {
    didTapButton!()
  }
  

  

  
}
// Disignated не позволяет получить convinience из коробки
// Его используем если нужно жестко передать Store Property

//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }


//  init(title: String,titleColor: UIColor, controlState: UIControl.State) {
//    super.init(frame: .zero)
//
//
//
//    backgroundColor = .gray
//    setTitle(title, for: .normal)
//    setTitleColor(titleColor,for: controlState)
//    titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//    constrainHeight(constant: 50)
//    layer.cornerRadius = 25
//
//    addTarget(self, action: #selector(handleTapButton), for: .touchUpInside)
//  }




//let loginButton: UIButton = {
//  let b = UIButton(type: .system)
//  b.setTitle("Login", for: .normal)
//  b.setTitleColor(.black, for: .disabled)
//  b.isEnabled = false
//  b.backgroundColor = .lightGray
//  b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//  b.constrainHeight(constant: 50)
//  b.layer.cornerRadius = 25
//
//  b.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
//  return b
//}()
