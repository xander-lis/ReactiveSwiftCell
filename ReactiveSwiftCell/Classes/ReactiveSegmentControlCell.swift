//
//  ReactiveSegmentControlCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

open class ReactiveSegmentControlCell: ReactiveTableViewdCell {
    @IBOutlet open weak var segmentControlView: UISegmentedControl!
    
    override open func valueChanged(_ sender: Any) {
        guard
            let sender = sender as? UISegmentedControl,
            let indexPath = indexPath
        else { return }
        inputCenter.broadcast(event: .updateSelectedIndex(value: sender.selectedSegmentIndex, indexPath: indexPath))
    }
}
