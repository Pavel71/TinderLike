//
//  SettingsTableViewCell.swift
//  CardsCourse
//
//  Created by PavelM on 17/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class SettingsTableViewCell: UITableViewCell {
  
  class SettingstTextField: UITextField {
    override var intrinsicContentSize: CGSize {
      return .init(width: 0, height: 40)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 20, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 20, dy: 0)
    }
  }
  
  
  let textField: SettingstTextField = {
    let tf = SettingstTextField()
    tf.placeholder = "Test"
//    tf.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
    
    return tf
  }()
  
//  var handleTextFieldClouser: ((SettingstTextField) -> Void)?
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setLayout()

  }
  
  private func setLayout() {
    
    addSubview(textField)
    textField.fillSuperview()
  }
  
//  @objc func handleTextFieldChange(textField: SettingstTextField) {
//    handleTextFieldClouser?(textField)
//  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  

  
}
