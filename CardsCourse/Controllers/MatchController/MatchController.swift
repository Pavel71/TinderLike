//
//  MatchController.swift
//  CardsCourse
//
//  Created by PavelM on 28/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit



class MatchController: UIViewController {
  
  
  var matchView: MatchView
  
  init(matchView: MatchView) {
    self.matchView = matchView
    super.init(nibName: nil, bundle: nil)
    
    view.addSubview(matchView)
    matchView.fillSuperview()

  }
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    

  }
  
  // MARK: SET UP LAyer
  

  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
