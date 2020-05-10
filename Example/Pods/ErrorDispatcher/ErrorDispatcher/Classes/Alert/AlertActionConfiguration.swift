//
//  AlertActionConfiguration.swift
//  
//
//  Created by Dmitriy Khalbaev on 08/06/2017.
//
//

import UIKit

public struct AlertActionConfiguration {
    public typealias Action = (() -> Void)
    
    public let title: String?
    public let style: UIAlertAction.Style
    public let action: Action?
    
    public init(title: String?, style: UIAlertAction.Style, action: Action?) {
        self.title = title
        self.style = style
        self.action = action
    }
}
