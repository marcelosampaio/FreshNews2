//
//  Source.swift
//  SwiftNetwokingLayer
//
//  Created by Marcelo on 22/09/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//
//
import Foundation

class Source {
    var category = String()
    var country = String()
    var description = String()
    var id = String()
    var language = String()
    var name = String()
    var url = String()
    
    init(dictionary: NSDictionary) {
        if let category = dictionary["category"] as? String {
            self.category = category
        }
        if let country = dictionary["country"] as? String {
            self.country = country
        }
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        if let id = dictionary["id"] as? String {
            self.id = id
        }
        if let language = dictionary["language"] as? String {
            self.language = language
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let url = dictionary["url"] as? String {
            self.url = url
        }
        
        
    }
    
    
    
    
    
    
}
