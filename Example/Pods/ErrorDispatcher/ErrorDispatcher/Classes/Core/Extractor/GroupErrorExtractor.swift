//
//  GroupErrorExtractor.swift
//  
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation

public class GroupErrorExtractor: ErrorExtractor {
    
    // MARK: Private properties
    fileprivate var extractors: [ErrorExtractor]
    
    public init(extractors: [ErrorExtractor]) {
        self.extractors = extractors
    }
    
    public func extract(error: Error) -> Error? {
        for extractor in extractors {
            guard let error = extractor.extract(error: error) else {
                continue
            }
            return error
        }
        
        return nil
    }
}
