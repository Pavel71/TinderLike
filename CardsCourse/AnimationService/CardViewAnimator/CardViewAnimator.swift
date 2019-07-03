//
//  CardViewAnimator.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class CardViewAnimator {
  
  static func performSwipeAnimation(duration: TimeInterval, transition: CGFloat, angle: CGFloat, cardView: CardView, complition: ((Bool) -> Void)? = nil) {
    
    let duration = duration
    let translation = CABasicAnimation(keyPath: "position.x")
    translation.toValue = transition
    translation.duration = duration
    translation.fillMode = .forwards
    translation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    translation.isRemovedOnCompletion = false
    
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.toValue = angle * CGFloat.pi / 180
    rotationAnimation.duration = duration
    
    // Создаем этот объект чтобы одновременно анимировать нескольок карт!
    
    
    cardView.layer.add(translation, forKey: "translation")
    cardView.layer.add(rotationAnimation, forKey: "rotation")
    
    
    
    CATransaction.setCompletionBlock {
      cardView.removeFromSuperview()
    }
    
    CATransaction.commit()
  }
  
}
