//
//  UserDetailsView.swift
//  CardsCourse
//
//  Created by PavelM on 25/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class UserDetailsView: UIScrollView,UIScrollViewDelegate {
  
  
  var cardViewModel: CardViewModel! {
    
    didSet {
      infoLabel.attributedText = cardViewModel.attributedString
      infoLabel.textAlignment = cardViewModel.textAlignment
      
      self.swipingPhotosController.cardViewModel = cardViewModel

    }
  }

  
  let swipingPhotosController = SwipingPhotosController()
  
  var swipingView: UIView!

  
  let infoLabel: UILabel = {
    let label = UILabel()
    label.text = "User name 30 \n Doctor \n Some Bio dow below"
    label.numberOfLines = 0
    return label
  }()
  
  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
    return button
  }()
  
  let userBottomStackView = UserDetailBotStackView()
  
  var didScrollValueChange: ((CGFloat) -> Void)?
  var didTapDismissButton: EmptyClouser?
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpScrollView()
    
    setUpImageView()
    setUpInfoLabel()
    setUpDismissButton()
    setUpBottomStakcView()
    
//    setupVisualBlurVisualEffect() только на 10ках
  }

  
  // MARK Set Up Layout
  
  private func setUpScrollView() {
    backgroundColor = .white
    // Позволяет Скролить по Вертикали Делает отсуп от SafeArria
    alwaysBounceVertical = true
    
    // Разместит Контент под шапку
    contentInsetAdjustmentBehavior = .never
    delegate = self
  }
  
  
  private func setUpImageView() {

    swipingView = swipingPhotosController.view!
    
    addSubview(swipingView)
    swipingView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2 + 50)
  }
  
  private func setUpInfoLabel() {
    addSubview(infoLabel)
    infoLabel.anchor(top: swipingView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 16))
  }
  
  private func setUpDismissButton() {
    
    addSubview(dismissButton)
    dismissButton.anchor(top: nil, leading: nil, bottom: swipingView.bottomAnchor, trailing: swipingView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: -20, right: 10),size: .init(width: 50, height: 50))
  }
  
  // Нужно прокинуть Таргеты!
  private func setUpBottomStakcView() {

    addSubview(userBottomStackView)
    userBottomStackView.anchor(top: nil, leading: nil, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 20, left: 20, bottom: 20, right: 20), size: .init(width: 300, height: 80))
    
    userBottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

  }
  
  // В основном он зайдет на 10ках!
  private func setupVisualBlurVisualEffect() {
    
    let blurEffecr = UIBlurEffect(style: .regular)
    let visualEffectView = UIVisualEffectView(effect: blurEffecr)
    
    addSubview(visualEffectView)
    visualEffectView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.topAnchor, trailing: trailingAnchor)
    
  }
  
  // MARK: Handele DismissButton
  
  @objc private func handleDismissButton() {
    didTapDismissButton!()
  }
  
  // MARK: ScrollViewDelegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let changeY = -scrollView.contentOffset.y
    
    didScrollValueChange!(changeY)
  }
  
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
