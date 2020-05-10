//
//  ReactiveSliderCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

open class ReactiveSliderCell: ReactiveTableViewdCell {
    @IBOutlet open weak var sliderView: UISlider!
    
    override open func valueChanged(_ sender: Any) {
        guard
            let sender = sender as? UISlider,
            let indexPath = indexPath
        else { return }
        inputCenter.broadcast(event: .updateSlider(value: sender.value, indexPath: indexPath))
    }
}
