//
//  ReactiveButtonCell.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 09.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

open class ReactiveButtonCell: ReactiveTableViewdCell {
    @IBOutlet open weak var button: UIButton!
    
    override open func touchUpInside(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        inputCenter.broadcast(event: .action(indexPath: indexPath))
    }
}
