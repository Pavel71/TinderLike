//
//  LoginService.swift
//  CardsCourse
//
//  Created by PavelM on 25/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation
import Firebase

class LoginService {
  
  
  static func sigIn(email: String, password: String,complation: @escaping (Result<AuthDataResult, NetworkFirebaseError>) -> Void) {
    
    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
      if let error = error {
        complation(.failure(.signInError))
      }
      guard let result = authDataResult else {return}
      complation(.success(result))
    }
  }
  
  static func logOut() -> Bool {
    do {
      try Auth.auth().signOut()
      return true
    } catch{
      return false
    }
  }
  
}
