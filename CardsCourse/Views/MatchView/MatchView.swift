//
//  MatchView.swift
//  CardsCourse
//
//  Created by PavelM on 28/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class MatchView: UIView {
  
  var blurView: UIVisualEffectView!
  
  // В обзервере стаим то что setUP 1 раз
  var cardUID: String! {
    didSet {
      
      fetchCardUser(cardUID: cardUID)

    }
  }
  
  var currentUser: User! {
    didSet {
      guard let url = URL(string: (currentUser.imageURlArray![0])) else {return}
      
      currentUserIamgeView.sd_setImage(with: url) { (_, _, _, _) in
        self.currentUserIamgeView.alpha = 1
      }
      
    }
  }
  
  fileprivate let itsAmatchImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "itsamatch"))
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "asdasdasdadsasd \n asdasd"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 0
    return label
  }()
  
  fileprivate let currentUserIamgeView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "jane2"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.borderWidth = 2
    iv.layer.borderColor = UIColor.white.cgColor
    iv.alpha = 0
    return iv
  }()
  
  fileprivate let cardtUserIamgeView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "kelly2"))
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.borderWidth = 2
    iv.layer.borderColor = UIColor.white.cgColor
    iv.alpha = 0
    return iv
  }()
  
  var sendMessageButton = SendMessageButton(type: .system)
  var keepSwipingButton = KeepSwipingButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setTapGestureRecogniser()
    setUPBlurEffect()
    
    setUPLayoutImage()
    setUPLogoAndDescription()
    setUPTopButtons()
    
    setUpAnimation()
  }
  

  
  // MARK: BackGroundBlur
  
  private func setUPBlurEffect() {
    let blurEffect = UIBlurEffect(style: .dark)
    blurView = UIVisualEffectView(effect: blurEffect)
    
    addSubview(blurView)
    blurView.fillSuperview()
    
    Animator.springAlpha(view: blurView, alphaBefore: 0, alphaAfter: 1)
    
  }
  
  
  // MARK: Set User Images
  private func setUPLayoutImage() {
    
    let imageWidth: CGFloat = 140
    currentUserIamgeView.layer.cornerRadius = imageWidth / 2
    cardtUserIamgeView.layer.cornerRadius = imageWidth / 2
    
    addSubview(currentUserIamgeView)
    currentUserIamgeView.anchor(top: nil, leading: nil, bottom: nil, trailing: centerXAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: imageWidth, height: imageWidth))
    
    addSubview(cardtUserIamgeView)
    cardtUserIamgeView.anchor(top: nil, leading: centerXAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0),size: .init(width: imageWidth, height: imageWidth))
    
    currentUserIamgeView.centerYInSuperview()
    cardtUserIamgeView.centerYInSuperview()
  }
  
  // MARK: Set Top Logo
  private func setUPLogoAndDescription() {
    
    let stackView = VerticalStackView(arrangedSubviews: [
      itsAmatchImageView,
      descriptionLabel
      ])
    
    stackView.distribution = .fillEqually
    addSubview(stackView)
    stackView.anchor(top: nil, leading: currentUserIamgeView.leadingAnchor, bottom: currentUserIamgeView.topAnchor, trailing: cardtUserIamgeView.trailingAnchor)
  }
  
  // MARK: Set Up Buttons
  private func setUPTopButtons() {

    sendMessageButton.didTapButton = didTapSendMessageButton
    keepSwipingButton.didTapButton  = didTapSwipingButton
    
    let verticalStackView = VerticalStackView(arrangedSubviews: [
      sendMessageButton,
      keepSwipingButton
      ], customSpacing: 5)
    verticalStackView.distribution = .fillEqually
    
    addSubview(verticalStackView)
    verticalStackView.anchor(top: cardtUserIamgeView.bottomAnchor, leading: currentUserIamgeView.leadingAnchor, bottom: nil, trailing: cardtUserIamgeView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    

  }
  private func didTapSendMessageButton() {
    print("TapTopButton")
  }
  private func didTapSwipingButton() {
    print("SwipingButton")
  }
  
  // MARK: Set UP Gesture
  private func setTapGestureRecogniser() {
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
  }
  
  @objc private func handleTapGesture() {
    
    Animator.springAlpha(view: self, alphaBefore: 1, alphaAfter: 0, complition: { _ in
      
      self.removeFromSuperview()
    })
    
    
  }
  
  // MARK: SetUpAnimation
  
  private func setUpAnimation() {
    
    MatchViewAnimator.animationMatchView(currentuser: currentUserIamgeView, carduser: cardtUserIamgeView, sendMessageButton: sendMessageButton, keepSwipingButton: keepSwipingButton)

  }
  
  
  // MARK: Network Layer
  
  private func fetchCardUser(cardUID: String) {
    
    FetchService.fetchUserToCardID(cardID: cardUID) { (result) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let data):
        guard let imagesUrlArray = data[UserKey.imageArray.rawValue] as? [String] else {return}
        guard let url = URL(string: imagesUrlArray[0]) else {return}
        // В конце мы подгружаем картинку!
        Animator.springAlpha(view: self.cardtUserIamgeView, alphaBefore: 0, alphaAfter: 1)
        self.cardtUserIamgeView.sd_setImage(with: url)
        let userName = data[UserKey.name.rawValue] as? String
        self.descriptionLabel.text = "Yuo and this MaZaFaker \(userName ?? "") matched"

      }
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
