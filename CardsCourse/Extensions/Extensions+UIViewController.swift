//
//  Extensions+UIViewController.swift
//  CardsCourse
//
//  Created by PavelM on 18/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


extension UIViewController {
  
  
  func showAlert(title: String, message: String) {
    
    let alertControlelr = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    alertControlelr.addAction(alertAction)
    present(alertControlelr, animated: true, completion: nil)
  }
  
}
