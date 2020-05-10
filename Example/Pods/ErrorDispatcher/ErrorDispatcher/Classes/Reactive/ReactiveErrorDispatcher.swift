//
//  ReactiveErrorDispatcher.swift
//  
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public class ReactiveErrorDispatcher: ErrorDispatcher {
    
    // MARK: Reactive
    public var action: Signal<PropositionAction, NoError>
    fileprivate var actionObserver: Signal<PropositionAction, NoError>.Observer
    
    public override init(proposer: ErrorProposer,
                         extractor: ErrorExtractor?) {
        (action, actionObserver) = Signal.pipe()
        
        super.init(proposer: proposer, extractor: extractor)
        
        self.executor = self
    }
}

// MARK: ErrorActionExecutor
extension ReactiveErrorDispatcher: ErrorActionExecutor {
    public func execute(action: PropositionAction) {
        actionObserver.send(value: action)
    }
}
