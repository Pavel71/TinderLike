//
//  Bindable.swift
//  CardsCourse
//
//  Created by PavelM on 14/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation

class Bindable<T> {
  
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: ((T?) -> Void)?
  
  func bind(observer: @escaping ((T?) -> Void)) {
    
    self.observer = observer
  }
}




//class myBandableClass<T> {
//
//  var value: T? {
//    didSet{
//      observer?(value) }
//  }
//
//  var observer: ((T?) -> Void)?
//
//  func bind(observ: @escaping ((T?) -> Void)) {
//
//    self.observer = observ
//  }
//}
