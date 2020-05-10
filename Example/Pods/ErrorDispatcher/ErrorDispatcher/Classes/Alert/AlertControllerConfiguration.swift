//
//  AlertControllerConfiguration.swift
//  
//
//  Created by Dmitriy Khalbaev on 08/06/2017.
//
//

import UIKit

/**
 Protocol for custom alert types
 */
public protocol CustomAlertConfiguration {}

/**
 Please, use this enum for show alerts.
 */
public enum AlertType {
    case system(AlertControllerConfiguration)
    case custom(CustomAlertConfiguration)
}

/**
 Configuration for UIAlertController
 */
public struct AlertControllerConfiguration {
    
    public let title: String?
    public let message: String?
    public let preferredStyle: UIAlertController.Style
    public var actions: [AlertActionConfiguration]
    public let sourceView: UIView?
    public let sourceRect: CGRect?
    
    public init(title: String?,
                message: String?,
                preferredStyle: UIAlertController.Style,
                actions: [AlertActionConfiguration]) {
        self.init(title: title, message: message,
                  preferredStyle: preferredStyle,
                  actions: actions, sourceView: nil,
                  sourceRect: nil)
    }
    
    public init(title: String?,
         message: String?,
         preferredStyle: UIAlertController.Style,
         actions: [AlertActionConfiguration],
         sourceView: UIView?,
         sourceRect: CGRect?) {
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.actions = actions
        self.sourceView = sourceView
        self.sourceRect = sourceRect
    }
    
    public init(title: String?,
                message: String?,
                preferredStyle: UIAlertController.Style,
                buttonTitle: String?,
                buttonAction: AlertActionConfiguration.Action?) {
        self.init(title: title, message: message,
                  preferredStyle: preferredStyle,
                  buttonTitle: buttonTitle,
                  buttonAction: buttonAction,
                  sourceView: nil, sourceRect: nil)
    }
    
    public init(title: String?,
         message: String?,
         preferredStyle: UIAlertController.Style,
         buttonTitle: String?,
         buttonAction: AlertActionConfiguration.Action?,
         sourceView: UIView?,
         sourceRect: CGRect?) {
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.sourceView = sourceView
        self.sourceRect = sourceRect
        
        self.actions = [AlertActionConfiguration(title: buttonTitle, style: .default, action: buttonAction)]
    }
}

// MARK: AlertController convience init
/**
 Extension for UIAlertController for AlertControllerConfiguration configuration
 */
public extension UIAlertController {
    convenience public init(configuration: AlertControllerConfiguration,
                     dismissHandler: (() -> Void)? = nil) {
        self.init(title: configuration.title, message: configuration.message, preferredStyle: configuration.preferredStyle)
        
        if configuration.preferredStyle == .actionSheet, UIDevice.current.userInterfaceIdiom == .pad {
            popoverPresentationController?.sourceView = configuration.sourceView
            guard let rect = configuration.sourceRect else {
                fatalError("Source rect must be defined for action sheet iPad")
            }
            popoverPresentationController?.sourceRect = rect
        }
        
        for action in configuration.actions {
            let action = UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.action?()
                dismissHandler?()
            })
            addAction(action)
        }
    }
}
