//
//  SourceViewModel.swift
//  SwiftNetwokingLayer
//
//  Created by Marcelo on 23/09/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class SourceViewModel {
    var name : String!
    var description : String!
    
    init(source: Source) {
        self.name = source.name
        self.description = source.description
    }
}
