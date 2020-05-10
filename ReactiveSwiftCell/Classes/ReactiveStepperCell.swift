//
//  ReactiveStepperCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

open class ReactiveStepperCell: ReactiveTableViewdCell {
    @IBOutlet open weak var stepperView: UIStepper!
    
    override open func valueChanged(_ sender: Any) {
        guard
            let sender = sender as? UIStepper,
            let indexPath = indexPath
        else { return }
        inputCenter.broadcast(event: .updateStepper(value: sender.value, indexPath: indexPath))
    }
}
