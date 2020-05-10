//
//  TextViewCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 03.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class TextViewCell: ReactiveTextViewCell {
    
    struct Model {
        let value: String
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            syncText = model?.value
            indexPath = model?.indexPath
            placeHolder = "Text View"
        }
    }
}
