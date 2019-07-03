//
//  RegisterService.swift
//  CardsCourse
//
//  Created by PavelM on 18/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase



class RegisterService {
  
  static func createUser(email: String, password: String, complation: @escaping ((Result<AuthDataResult, NetworkFirebaseError>) -> Void)) {
    
    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
      
      if let err = err {
        complation(.failure(.createUserError))
        
      }
      if let res = result {
        complation(.success(res))
      }
      
    }
  }
  
}
