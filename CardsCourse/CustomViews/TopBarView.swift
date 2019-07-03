//
//  TopBarView.swift
//  CardsCourse
//
//  Created by PavelM on 26/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class TopBarView: UIView {
  
  let barStackView = UIStackView(arrangedSubviews: [])
  let count: Int
  
  let deSelectedBarColor = UIColor(white: 0, alpha: 0.1)
  
  init(frame: CGRect, count: Int) {
    self.count = count
    super.init(frame: frame)
    
    fillBarStackView()
    
    layoutBarStackView()
  }
  
  private func fillBarStackView() {
    
    for _ in 1...count {
      let barView = UIView()
      barView.backgroundColor = deSelectedBarColor
      barView.layer.cornerRadius = 2
      
      barStackView.addArrangedSubview(barView)
    }
    
    barStackView.spacing = 4
    barStackView.distribution = .fillEqually
    
    barStackView.arrangedSubviews.first?.backgroundColor = .white
    
  }
  
  private func layoutBarStackView() {
    addSubview(barStackView)
    barStackView.fillSuperview()
  }
  
  func selectBar(index: Int) {
    
    self.barStackView.arrangedSubviews.forEach {$0.backgroundColor = self.deSelectedBarColor}
    
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
      self.barStackView.arrangedSubviews[index].backgroundColor = .white
    })
    
    
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
