//
//  ErrorPoposer.swift
//  
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation

public enum Proposition {
    case single(PropositionAction)
    case group([PropositionAction])
}

public enum PropositionAction {
    case nothing
    case logout
    case tokenExpired
    case alert(AlertType)
    case custom(CustomPropositionAction)
}

public protocol CustomPropositionAction {}

public protocol ErrorProposer {
    func proposeAction(for error: Error) -> Proposition?
}
