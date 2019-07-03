//
//  CardView.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class CardView: UIView {
  
  var nextCardView: CardView?
  var didRemoveCardView: EmptyClouser?
  var saveSwipeFirestore: SendValueClouser<Int>?
  
//  var user: User!
  var cardViewModel: CardViewModel! {
    
    didSet {
      
      swipingPhotoController.cardViewModel = cardViewModel
      
      infoLabel.numberOfLines = 0
      infoLabel.textColor = .white
      infoLabel.attributedText = cardViewModel.attributedString
      infoLabel.textAlignment = cardViewModel.textAlignment

    }
  }

  
  fileprivate let swipingPhotoController = SwipingPhotosController(isCardViewMode: true)
  
  fileprivate let gradientLayer = CAGradientLayer()
  fileprivate let infoLabel = UILabel()
  fileprivate var barsStackView: TopBarView!
  
  fileprivate let moreinfoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleMoreInfoButton), for: .touchUpInside)
    return button
  }()
  

  
  fileprivate let trashold: CGFloat = 100
  
  // MARK: Send CardViewModel
  
  var didTapMoreInfoClouser: ((CardViewModel) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    setUplayoutView()
    setUPGesterRecogniser()
    
  }
  
  override func layoutSubviews() {

    gradientLayer.frame = self.frame
  }
  
  private func setUPGesterRecogniser() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)

  }
  
  
  // MARK: SetUP Layout
  
  private func setUplayoutView() {
    
    layer.cornerRadius = 10
    clipsToBounds = true
    
    
    setUpSwipingController()
    
    // Add GradientLayer
    setUpGradientlayer()
    
    setUpInfoLabel()
    
    
    setUpMoreInfoButton()
  }
  
  private func setUpSwipingController() {
    
    let swipingPhotosView = swipingPhotoController.view!

    addSubview(swipingPhotosView)
    swipingPhotosView.fillSuperview()
  }
  
  private func setUpInfoLabel() {
    addSubview(infoLabel)
    infoLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
  }
  
  private func setUpMoreInfoButton() {
    addSubview(moreinfoButton)
    moreinfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 10),size: .init(width: 50, height: 50))
  }

  
  private func setUpGradientlayer() {
    
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.5,1.1]
    
    layer.addSublayer(gradientLayer)
  }
  
  
  
  // MARK: Tap MoreInfo Button
  @objc private func handleMoreInfoButton() {
    
    didTapMoreInfoClouser!(self.cardViewModel)
  }
  
  
  // MARK: PAN Gesture Controll!
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    
    // rotation

    switch gesture.state {
      
    case .began:
      
      // Этот метода важен чтобы не мешалось с .changed и не запускалась анимация!
      superview?.subviews.forEach({ (subView) in
        subView.layer.removeAllAnimations()
      })
      
    case .ended:

      endPanGesture(gesture)

    case .changed:
    
      changedPanGesture(gesture)
      
    default:
      break
    }

  }
  // Заканчивается анимация смещения карточки
  var dismissCardClouser: SendValueClouser<Int>?
  // MARK: Did fifnish Animation Card
  private func endPanGesture(_ gesture: UIPanGestureRecognizer) {
    
    let shouldDismissCard = abs(gesture.translation(in: nil).x) > trashold
    
    if shouldDismissCard {
      
      // Можно здесь прокинуть clouser на like или dislike
      
      let sign = Int(gesture.translation(in: nil).x).signum()
      
      dismissCardClouser!(sign == -1 ? 0 : 1)
      
    } else {
      Animator.springTranslated(view: self, cgaTransform: .identity)
    }
  }
  
  private func changedPanGesture(_ gesture: UIPanGestureRecognizer) {
    
    let translation = gesture.translation(in: nil)
    let degree: CGFloat = translation.x / 20
    let angle = degree * .pi / 180
    
    let rotationTransform = CGAffineTransform(rotationAngle: angle)
    
    transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
  }
  

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
