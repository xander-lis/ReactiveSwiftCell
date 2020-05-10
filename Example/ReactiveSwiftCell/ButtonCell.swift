//
//  ButtonCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class ButtonCell: ReactiveButtonCell {
    
    struct Model {
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            indexPath = model?.indexPath
        }
    }
    
    override open func touchUpInside(_ sender: Any) {
        super.touchUpInside(sender)
        button.isEnabled = !button.isEnabled
    }
}
