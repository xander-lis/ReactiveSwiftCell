//
//  AlertStrings.swift
//  
//
//  Created by Dmitriy Khalbaev on 22/02/2018.
//
//

import Foundation

public enum AlertStrings: String {
    case warning = "Warning"
    case error = "Error"
    case attention = "Attention"
    case sessionExpired = "Session expired"
    case ok = "OK"
    case cancel = "Cancel"
    case yes = "Yes"
    case no = "No"
    
    public var localized: String {
        return NSLocalizedString(rawValue, comment: "Alert string")
    }
}
