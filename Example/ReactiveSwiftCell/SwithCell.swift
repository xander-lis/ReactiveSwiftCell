//
//  SwithCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 03.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class SwithCell: ReactiveSwitchCell {
    
    struct Model {
        let value: Bool
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            indexPath = model?.indexPath
            guard let value = model?.value else { return }
            swithView.isOn = value
        }
    }
}
