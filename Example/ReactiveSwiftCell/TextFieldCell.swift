//
//  TextFieldCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 02.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class TextFieldCell: ReactiveTextFieldCell {
    
    struct Model {
        let value: String
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            textField.text = model?.value
            indexPath = model?.indexPath
            guard let indexPath = model?.indexPath else { return }
            textField.placeholder = "Text Field \(indexPath.row + 1)"
        }
    }
}
