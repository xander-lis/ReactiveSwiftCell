//
//  StepperCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class StepperCell: ReactiveStepperCell {
    @IBOutlet private weak var valueLabel: UILabel!
    
    struct Model {
        let value: Double
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            indexPath = model?.indexPath
            guard let value = model?.value else { return }
            stepperView.value = value
            valueLabel.text = "Value \(Int(value))"
        }
    }
    
    override open func valueChanged(_ sender: Any) {
        super.valueChanged(sender)
        guard let sender = sender as? UIStepper else { return }
        valueLabel.text = "Value \(Int(sender.value))"
    }
}
