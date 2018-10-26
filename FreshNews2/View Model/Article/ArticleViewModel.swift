//
//  ArticleViewModel.swift
//  FreshNews2
//
//  Created by Marcelo on 21/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class ArticleViewModel {
    var urlToImage : String!
    var description : String!
    var title : String!
    var publishedAt : String!
    var author : String!
    var url : String!
    
    init() {
        self.urlToImage = String()
        self.description = String()
        self.title = String()
        self.publishedAt = String()
        self.author = String()
        self.url = String()
    }
    
    init(article: Article) {
        self.urlToImage = article.urlToImage
        self.description = article.description
        self.title = article.title
        self.publishedAt = article.publishedAt
        self.author = article.author
        self.url = article.url
    }
    
    
    
    
}
