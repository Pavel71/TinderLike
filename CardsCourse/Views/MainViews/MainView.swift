//
//  MainView.swift
//  CardsCourse
//
//  Created by PavelM on 10/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class MainView: UIView {
  
  let topStackView = TopNavigationStackView()
  let cardDeckView = UIView()
  let bottomStackView = BottomStackView()
  
  var didTapMoreInfoButtonClouser: ((CardViewModel) -> Void)?
  

  
  override init(frame: CGRect) {
    super.init(frame:frame)

    backgroundColor = .white

    setLayout()


  }
  
  func setUPCardFromUser(user: User) -> CardView {
    
    let cardView = CardView()
    cardView.cardViewModel = user.toCardViewModel()
    cardDeckView.addSubview(cardView)
    // Самый первый покажи первым! Последний в самой глубине!
    cardDeckView.sendSubviewToBack(cardView)
    // передаем мосты в Controller
    cardView.didTapMoreInfoClouser = didTapMoreInfoButtonClouser
    
    cardView.fillSuperview()
    
    return cardView
  }

  
  private func setLayout() {
    
    let overallStackView = UIStackView(arrangedSubviews: [
      topStackView,
      cardDeckView,
      bottomStackView
      ])
    overallStackView.axis = .vertical
    
    addSubview(overallStackView)
    overallStackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
    
    overallStackView.isLayoutMarginsRelativeArrangement = true
    overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
    
    // Метод Выносит на верхную границу именно ту View!
    overallStackView.bringSubviewToFront(cardDeckView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
