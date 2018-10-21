//
//  News.swift
//  FreshNews2
//
//  Created by Marcelo on 21/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class News {
    var status = String()
    var articles = [Article]()
    var source = String()
    var sortBy = String()
    
    
    init(dictionary: NSDictionary) {
        
        if let status = dictionary["status"] as? String {
            self.status = status
        }
        if let source = dictionary["source"] as? String {
            self.source = source
        }
        if let sortBy = dictionary["sortBy"] as? String {
            self.sortBy = sortBy
        }
       
        // articles
        let array = dictionary["articles"] as! NSArray
        for item in array {
            let itemDic = item as! NSDictionary
            let article = Article(dictionary: itemDic)
            articles.append(article)
        }
        
    }
        
        
}
