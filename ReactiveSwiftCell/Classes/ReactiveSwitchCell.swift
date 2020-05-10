//
//  ReactiveSwitchCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 03.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import ReactiveSwift

open class ReactiveSwitchCell: ReactiveTableViewdCell {
    @IBOutlet open weak var swithView: UISwitch!
    
    override open func valueChanged(_ sender: Any) {
        guard
            let sender = sender as? UISwitch,
            let indexPath = indexPath
        else { return }
        inputCenter.broadcast(event: .updateSwitch(value: sender.isOn, indexPath: indexPath))
    }
}
