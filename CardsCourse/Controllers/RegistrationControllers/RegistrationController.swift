//
//  RegistrationController.swift
//  CardsCourse
//
//  Created by PavelM on 13/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationController: UIViewController {
  
  let selectPhotoButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Select Photo", for: .normal)
    b.setTitleColor(.black, for: .normal)
    b.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    b.backgroundColor = .white
    b.constrainHeight(constant: 200)
    b.layer.cornerRadius = 16
    
    b.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
    
    b.imageView?.contentMode = .scaleAspectFill
    b.clipsToBounds = true
    return b
  }()
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 16)
    tf.placeholder = "Enter Full name"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  
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
  
  let registerButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Register", for: .normal)
    b.setTitleColor(.black, for: .disabled)
    b.isEnabled = false
    b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    b.backgroundColor = .lightGray
    b.constrainHeight(constant: 50)
    b.layer.cornerRadius = 25
    
    b.addTarget(self, action: #selector(handleRegistrationButton), for: .touchUpInside)
    return b
  }()
  
  let goToLoginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Go to Login", for: .normal)
    button.setTitleColor(.white, for: .normal)
 
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
    
    return button
  }()
  
  
  
  lazy var verticalStackView:UIStackView = {
    let sv = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      registerButton
      ])
    sv.axis = .vertical
    sv.spacing = 5
    sv.distribution = .fillEqually
    return sv
  }()
  
  lazy var overallStackView = UIStackView(arrangedSubviews: [
    selectPhotoButton,
    verticalStackView
    ])
  
  let gradientLayer = CAGradientLayer()
  let registrationViewModel = RegistrationViewModel()
 

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupGradienLayer()
    setupLayout()
    
    addTapGestureRecognizer()
    

    // Set Up RegistrationObserver
    setupRegistratioViewModelObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Здесь так как они будут включатся при призентации!
    setKeyboardNotification()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // remove all Notification!
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Layout
  
  private func setupLayout() {
    
    navigationController?.isNavigationBarHidden = true
    
    overallStackView.axis = .vertical
    overallStackView.spacing = 5
    
    
    view.addSubview(overallStackView)
    selectPhotoButton.constrainWidth(constant: 200)
    
    overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 30))
    overallStackView.centerYInSuperview()
    
    view.addSubview(goToLoginButton)
    goToLoginButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)

  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = view.bounds
  }
  
  private func setupGradienLayer() {
    
    let topColor = #colorLiteral(red: 0.9904382825, green: 0.3463218808, blue: 0.3828873634, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.8960273266, green: 0.1142120436, blue: 0.4684556723, alpha: 1)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor ]
    gradientLayer.locations = [0,1]
    
    view.layer.addSublayer(gradientLayer)
    
  }
  
  // MARK: HandleGoToLogin Button
  
  @objc private func handleGoToLogin() {
    
//    let loginController = LoginController()
//    navigationController?.pushViewController(loginController, animated: true)
    navigationController?.popViewController(animated: true)

  }
  
 
  
  // MARK: Set WillShow Cancel Keyboard
  
  private func setKeyboardNotification() {
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleWillShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  // Клавиватура Появилась
  @objc private func handleWillShowKeyboard(notification: Notification) {
    // Достаем по ключу значение
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    let keyBoardFrame = value.cgRectValue

    
    let bottomGapFromStackViewAndBotton = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
    
    let difference = keyBoardFrame.height - bottomGapFromStackViewAndBotton

    Animator.springTranslated(view: view, cgaTransform: CGAffineTransform(translationX: 0, y: -difference - 8))
    
  }
  
  // Клавиатура Скрылась
  @objc private func handleKeyBoardHide(notification: Notification) {
    Animator.springTranslated(view: view, cgaTransform: .identity)
  }
  
  // MARK: Tap View Gesture

  private func addTapGestureRecognizer() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapView))
    
    view.addGestureRecognizer(tapGestureRecognizer)
  }
  @objc func handleTapView() {
    view.endEditing(true)
  }
  
  // MARK: Trait Collection
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
    if self.traitCollection.verticalSizeClass == .compact {
      overallStackView.axis = .horizontal
    } else {
      overallStackView.axis = .vertical
    }
  }
  
  
  
 
  // MARK:  Set UP Observer
  
  
  private func setupRegistratioViewModelObserver() {
    
    registrationViewModel.bindableISFormValid.bind(observer: chekForm)
    
    registrationViewModel.bindableImage.bind(observer: setChooseImage)

  }
  
  private func setChooseImage(image: UIImage?) {
    
    guard let image = image else {return}
    selectPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
  }
  
  private func chekForm(isFormValid: Bool?) {
    
    guard let isFormValid = isFormValid else {return}
    registerButton.isEnabled = isFormValid
    if isFormValid {
      registerButton.setTitleColor(.white, for: .normal)
      registerButton.backgroundColor = #colorLiteral(red: 0.8327895403, green: 0.09347004443, blue: 0.3214370608, alpha: 1)
    } else {
      registerButton.setTitleColor(.black, for: .normal)
      registerButton.backgroundColor = .lightGray
    }
  }
  
  // MARK: TextField Handle
  
  @objc private func handleTextChange(textField: UITextField) {
    
    switch textField {
      
    case fullNameTextField:
      registrationViewModel.fullName = textField.text
    case emailTextField:
      registrationViewModel.email = textField.text
    case passwordTextField:
      registrationViewModel.password = textField.text
    default:
      break
    }
 
  }
  
  // MARK: Registration in Firebase
  var registerHUD: JGProgressHUD = {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Register"
    return hud
  }()
  
  @objc private func handleRegistrationButton() {
    // Убрать клавиатуру
    handleTapView()
    
    registerHUD.show(in: view)
    
    registrationViewModel.performRegistration { (result) in
     
      
      switch result {
      case .failure(let error):
        self.showHUDWithError(error)
      case .success(_):
        self.registerHUD.dismiss()
        print("Registration Sucsess!")
        
        self.present(MainController(), animated: true, completion: nil)
      }
    }

    
  }
  
  fileprivate func showHUDWithError(_ error: Error) {
    
    registerHUD.dismiss()
    
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Failed registration"
    hud.detailTextLabel.text = error.localizedDescription
    hud.show(in: self.view)
    hud.dismiss(afterDelay: 4)
  }
  
  @objc private func handleSelectButton() {
    print("Select Photo")
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
  }
  
}
// MARK: ImagePickerDelegate and NavigationDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // это когда выбираем картинку
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = info[.originalImage] as? UIImage
    registrationViewModel.bindableImage.value = image
    registrationViewModel.checkFormValidity()
    dismiss(animated: true, completion: nil)
  }
  

  
}



