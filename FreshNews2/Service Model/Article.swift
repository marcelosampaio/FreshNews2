//
//  Article.swift
//  FreshNews2
//
//  Created by Marcelo on 21/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class Article {
    
    var urlToImage = String()
    var description = String()
    var title = String()
    var publishedAt = String()
    var author = String()
    var url = String()

    init(dictionary: NSDictionary) {
        
        if let urlToImage = dictionary["urlToImage"] as? String {
            self.urlToImage = urlToImage
        }
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let publishedAt = dictionary["publishedAt"] as? String {
            self.publishedAt = publishedAt
        }
        if let author = dictionary["author"] as? String {
            self.author = author
        }
        if let url = dictionary["url"] as? String {
            self.url = url
        }

    }
}


