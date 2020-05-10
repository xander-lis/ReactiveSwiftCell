//
//  DefaultErrorProposer.swift
//  ErrorDispatcher
//
//  Created by Dmitriy Khalbaev on 06/06/2018.
//

import Foundation

public class DefaultErrorProposer: ErrorProposer {
    
    // MARK: Public properties
    public var message: String = NSLocalizedString("Oops. Something went wrong.",
                                                   comment: "Error")
    
    public func proposeAction(for error: Error) -> Proposition? {
        let title = AlertStrings.error.localized
        let dismissTitle = AlertStrings.ok.localized
        let alert = AlertControllerConfiguration(title: title,
                                                 message: message,
                                                 preferredStyle: .alert,
                                                 buttonTitle: dismissTitle,
                                                 buttonAction: nil)
        let alertType: AlertType = .system(alert)
        return .single(.alert(alertType))
    }
    
    public init() {
        
    }
}
