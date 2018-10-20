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
    var category : String!
    var country : String!
    
    init(source: Source) {
        self.name = source.name
        self.description = source.description
        self.category = source.category
        self.country = source.country
    }
}
