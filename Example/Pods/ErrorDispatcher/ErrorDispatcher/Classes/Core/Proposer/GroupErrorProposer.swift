//
//  GroupErrorProposer.swift
//
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation

public class GroupErrorProposer: ErrorProposer {
    
    // MARK: Private properties
    fileprivate var proposers: [ErrorProposer]
    
    public init(proposers: [ErrorProposer]) {
        self.proposers = proposers
    }
    
    public func proposeAction(for error: Error) -> Proposition? {
        for proposer in proposers {
            guard let action = proposer.proposeAction(for: error) else {
                continue
            }
            return action
        }
        return nil
    }
}
