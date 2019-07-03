//
//  AgeRangeCell.swift
//  CardsCourse
//
//  Created by PavelM on 24/06/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class AgeRangeCell: UITableViewCell {
  
  let minSlider:UISlider = {
    
    let slider = UISlider()
    slider.minimumValue = 18
    slider.maximumValue = 100
    slider.tag = 0
    return slider
  }()
  
  let maxSlider:UISlider = {
    
    let slider = UISlider()
    slider.minimumValue = 18
    slider.maximumValue = 100
    slider.tag = 1
    
    return slider
  }()
  
  var minLabel: UILabel = {
    let label = AgeRangeLabel()
    label.text = "Min: 18"
    label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    label.textAlignment = .right
    return label
  }()
  
  var maxLabel: UILabel = {
    let label = AgeRangeLabel()
    label.text = "Max: 50"
    label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    label.textAlignment = .right
    return label
  }()
  
  class AgeRangeLabel: UILabel {
    override var intrinsicContentSize: CGSize {
      return .init(width: 85, height: 0)
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
    let minLabelSliderStackView = UIStackView(arrangedSubviews: [minLabel,minSlider])
    
    minLabelSliderStackView.spacing = 10
    
    let maxLabelSliderStackView = UIStackView(arrangedSubviews: [maxLabel,maxSlider])
    maxLabelSliderStackView.spacing = 10
    
    let overAllStackView = VerticalStackView(arrangedSubviews: [
        minLabelSliderStackView,
        maxLabelSliderStackView,
        
      ], customSpacing: 10)

    overAllStackView.isLayoutMarginsRelativeArrangement = true
    overAllStackView.layoutMargins = .init(top: 10, left: 0, bottom: 10, right: 10)

    
    addSubview(overAllStackView)
    overAllStackView.fillSuperview()

  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
