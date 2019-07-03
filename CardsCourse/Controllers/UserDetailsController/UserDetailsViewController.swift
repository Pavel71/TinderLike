//
//  UserDetailsViewController.swift
//  CardsCourse
//
//  Created by PavelM on 25/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class UserDetailsViewController: UIViewController {
  
  var userDetailView: UserDetailsView!
  
  var cardViewModel: CardViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUserDetailsView()
    setObserverFromView()
    
    setUserDataFromCardViewModel()
    
  }
  
  // MARK: SetUpLayout
  
  private func setUpUserDetailsView() {
    
    userDetailView = UserDetailsView(frame: view.frame)
    view.addSubview(userDetailView)


  }
  
  // MARK: Set UserDataFromCardViewModel
  
  private func setUserDataFromCardViewModel() {
    userDetailView.cardViewModel = cardViewModel
  }
  
  // MARK: Set Observer from View
  
  private func setObserverFromView() {
    userDetailView.didScrollValueChange = changeContenOffset
    userDetailView.didTapDismissButton = handleTapDismiss

    userDetailView.userBottomStackView.dismissButton.addTarget(self, action: #selector(didTapDissmisCircleButton), for: .touchUpInside)
    userDetailView.userBottomStackView.likeButton.addTarget(self, action: #selector(didTapLikeCircleButton), for: .touchUpInside)
    userDetailView.userBottomStackView.starButton.addTarget(self, action: #selector(didTapStarCircleButton), for: .touchUpInside)
 
  }
  
  // MARK: Handle Bottom Buttons
  
  @objc private func didTapDissmisCircleButton() {
    print("Dismiss Circle")
  }
  
  @objc private func didTapLikeCircleButton() {
    print("Like Circle")
  }
  
  @objc private func didTapStarCircleButton() {
    print("Star Circle")
  }
  
  // MARK: Handle scroll contentY
  
  private func changeContenOffset(contentY: CGFloat) {

    if contentY > 0 {
      let width = view.frame.width + contentY * 2
      userDetailView.swipingView.frame = CGRect(x: -contentY, y: -contentY, width: width, height: width + 50)
    }

  }

  private func handleTapDismiss() {
    self.dismiss(animated: true)
    
  }
}
