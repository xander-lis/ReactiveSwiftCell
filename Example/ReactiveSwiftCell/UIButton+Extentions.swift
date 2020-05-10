//
//  UIButton+Extentions.swift
//  ReactiveSwiftCell
//
//  Created by Aleksandr Lis on 10.05.2020.
//  Copyright © 2020 Aleksandr Lis. All rights reserved.
//

import UIKit

extension UIButton {
    override open var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.3
        }
    }
}
