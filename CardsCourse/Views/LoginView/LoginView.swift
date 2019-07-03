//
//  LoginView.swift
//  CardsCourse
//
//  Created by PavelM on 24/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit



class LoginView: UIView {
  
  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 16)
    tf.placeholder = "Enter email"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    tf.keyboardType = .emailAddress
    return tf
  }()
  
  let passwordTextField: CustomTextField = {
    let tf = CustomTextField(padding: 16)
    tf.placeholder = "Enter password"
    tf.backgroundColor = .white
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    
    return tf
  }()
  
  let loginButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Login", for: .normal)
    b.setTitleColor(.black, for: .disabled)
    b.isEnabled = false
    b.backgroundColor = .lightGray
    b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    b.constrainHeight(constant: 50)
    b.layer.cornerRadius = 25
    
    b.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
    return b
  }()
  
  let goToRegistrationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Go back to Registration", for: .normal)
    button.setTitleColor(.white, for: .normal)
    
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    button.addTarget(self, action: #selector(handleGoToRegister), for: .touchUpInside)
    
    return button
  }()
  
  lazy var overAllStackView = VerticalStackView(arrangedSubviews: [
    emailTextField,
    passwordTextField,
    loginButton
    ], customSpacing: 5)
  
  let gradientLayer = CAGradientLayer()
  
  override init(frame: CGRect) {
    super.init(frame:frame)
    
    setUpGradientlayer()
    
    overAllStackView.distribution = .fillEqually
    
    addSubview(overAllStackView)
    overAllStackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 30))
    overAllStackView.centerYInSuperview()
    
    addSubview(goToRegistrationButton)
    goToRegistrationButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)

  }
  
  // Нужно вызвать определение Layout заново
  override func layoutSubviews() {
    gradientLayer.frame = frame
  }
  
  private func setUpGradientlayer() {

    let topColor = #colorLiteral(red: 0.9904382825, green: 0.3463218808, blue: 0.3828873634, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.8960273266, green: 0.1142120436, blue: 0.4684556723, alpha: 1)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor ]
    gradientLayer.locations = [0,1]
    
    layer.addSublayer(gradientLayer)
    
    
  }
  
  var didTextChangeClouser: ((UITextField) -> Void)?
  
  @objc private func handleTextChange(textField: UITextField) {
    didTextChangeClouser!(textField)
  }
  
  var didTapLoginButtonClouser: (() -> Void)?
  @objc private func handleLoginButton() {
    didTapLoginButtonClouser!()
  }
  
  var didTapGoToBackRegistration: (() -> Void)?
  @objc private func handleGoToRegister() {
    didTapGoToBackRegistration!()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
