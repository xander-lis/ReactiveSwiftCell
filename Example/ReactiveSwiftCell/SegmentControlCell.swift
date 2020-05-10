//
//  SegmentControlCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit
import ReactiveSwiftCell

class SegmentControlCell: ReactiveSegmentControlCell {

    struct Model {
        let value: Int
        let indexPath: IndexPath
    }
    
    var model: Model? {
        didSet {
            indexPath = model?.indexPath
            guard let value = model?.value else { return }
            segmentControlView.selectedSegmentIndex = value
        }
    }
    
    override open func valueChanged(_ sender: Any) {
        super.valueChanged(sender)
    }
}
