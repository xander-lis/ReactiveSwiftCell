//
//  ErrorExtractor.swift
//  
//
//  Created by Dmitriy Khalbaev on 05/06/2018.
//  Copyright © 2018 Dmitriy Khalbaev. All rights reserved.
//

import Foundation

public protocol ErrorExtractor {
    func extract(error: Error) -> Error?
}
