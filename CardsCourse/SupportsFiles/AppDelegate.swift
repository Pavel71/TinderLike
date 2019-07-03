//
//  AppDelegate.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    root()
    
    return true
  }
  
  func root() {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
//    let navController = UINavigationController(rootViewController: RegistrationController())
    
//     SwipingPhotosController(transitionStyle:.scroll, navigationOrientation: .horizontal)
    
    window?.rootViewController = UINavigationController(rootViewController: MainController())
    
  }

  


}

