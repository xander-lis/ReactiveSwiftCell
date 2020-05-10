//
//  ErrorDispatcher.swift
//  
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation

public protocol ErrorActionExecutor: class {
    func execute(action: PropositionAction)
}

public class ErrorDispatcher {
    
    public weak var executor: ErrorActionExecutor?
    
    // MARK: Private properties
    fileprivate var proposer: ErrorProposer
    fileprivate var extractor: ErrorExtractor?
    
    public init(proposer: ErrorProposer,
                extractor: ErrorExtractor?) {
        self.proposer = proposer
        self.extractor = extractor
    }
    
    /**
     Method that return action
     */
    public func handle(error: Error) {
        let error = extractor?.extract(error: error) ?? error
        
        guard let action = proposer.proposeAction(for: error) else {
            print("Unhandled error: \(error)")
            return
        }
        
        switch action {
        case .single(let action):
            executor?.execute(action: action)
        case .group(let actions):
            for action in actions {
                executor?.execute(action: action)
            }
        }
    }
}
