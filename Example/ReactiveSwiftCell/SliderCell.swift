//
//  SliderCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class SliderCell: ReactiveSliderCell {
    
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var minValueLabel: UILabel!
    @IBOutlet private weak var maxValueLabel: UILabel!
    
    @IBOutlet private weak var valueLeftConstraint: NSLayoutConstraint!
    
    struct Model {
        let value: Float
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            indexPath = model?.indexPath
            guard let value = model?.value else { return }
            sliderView.value = value
        }
    }
    
    override func setup() {
        minValueLabel.text = "0"
        maxValueLabel.text = "100"
        sliderView.minimumValue = Float(0)
        sliderView.maximumValue = Float(100)
    }
    
    private func setupValueLabel() {
        valueLabel.text = "\(Int(sliderView.value))"
        valueLabel.sizeToFit()
        
        let rect = sliderView.thumbRect(forBounds: sliderView.bounds,
                                        trackRect: sliderView.trackRect(forBounds: sliderView.bounds),
                                        value: sliderView.value)

        let thumbRect = convert(rect, from: sliderView)

        valueLeftConstraint.constant = thumbRect.origin.x - valueLabel.frame.width / 2
    }
    
    override open func valueChanged(_ sender: Any) {
        super.valueChanged(sender)
        valueLabel.isHidden = false
        setupValueLabel()
    }
    
    override open func touchUpInside(_ sender: Any) {
        valueLabel.isHidden = true
    }
}
