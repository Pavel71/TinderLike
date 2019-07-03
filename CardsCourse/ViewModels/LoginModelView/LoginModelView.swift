//
//  LoginModelView.swift
//  CardsCourse
//
//  Created by PavelM on 25/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase

class LoginModelView {
  
  var email: String? { didSet {checkForm()} }
  var password: String? {didSet {checkForm()} }
  
  var isValidForm = Bindable<Bool>()
  var isLogIn = Bindable<Bool>()
  
  func checkForm() {
    isValidForm.value = email?.isEmpty == false && password?.isEmpty == false 
  }
  
  func performSignIn(complation: @escaping (Result<AuthDataResult, NetworkFirebaseError>) -> Void) {
    isLogIn.value = true
    guard let email = self.email else {return}
    guard let password = self.password else {return}
    
    LoginService.sigIn(email: email, password: password, complation: complation)
  }
  
  
  
}
