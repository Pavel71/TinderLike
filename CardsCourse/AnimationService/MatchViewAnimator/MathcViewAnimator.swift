//
//  MathcViewAnimator.swift
//  CardsCourse
//
//  Created by PavelM on 02/07/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit



class MatchViewAnimator {
  
  
  static func animationMatchView(currentuser: UIImageView, carduser: UIImageView, sendMessageButton: UIButton, keepSwipingButton: UIButton) {
    
    let angle = 30 * CGFloat.pi / 180
    
    let transLationPositiv = CGAffineTransform(rotationAngle: -angle).concatenating(.init(translationX: 200, y: 0))
    
    let transLationNegativ = CGAffineTransform(rotationAngle: angle).concatenating(.init(translationX: -200, y: 0))
    
    // Set up init position
    currentuser.transform = transLationPositiv
    carduser.transform = transLationNegativ
    
    sendMessageButton.transform = CGAffineTransform(translationX: -500, y: 0)
    keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)
    
    UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: .calculationModeCubic, animations: {
      // translation
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: {
        // тоесть здесь мы говорим чтобы осталься просто угол
        // а смещение таким образом уйдет
        // Тоесть мы как бы отрезали 1 transform
        currentuser.transform = CGAffineTransform(rotationAngle: -angle)
        carduser.transform = CGAffineTransform(rotationAngle: angle)
        
      })
      // rotation
      UIView.addKeyframe(withRelativeStartTime: 0.6
        , relativeDuration: 0.6, animations: {
          currentuser.transform = .identity
          carduser.transform = .identity

      })
      
    }) { (_) in
      
      
    }
    // Запускаем здесь чтобы была раскачечка!
    UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
      sendMessageButton.transform = .identity
      keepSwipingButton.transform = .identity
    })
  }
}
