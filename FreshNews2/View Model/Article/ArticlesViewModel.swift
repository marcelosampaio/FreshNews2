//
//  ArticlesViewModel.swift
//  FreshNews2
//
//  Created by Marcelo on 21/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class ArticlesViewModel {
    public var articles : [ArticleViewModel] = [ArticleViewModel]()
    private var webService = WebService()
    
    init(provider: ProviderType, sourceId: String, completion: @escaping () -> ()) {
        
        if provider == ProviderType.web {
            //web
            webService.getNews(sourceId: sourceId) { (resultArticles) in
                if resultArticles.count > 0 {
                    self.articles = resultArticles.map(ArticleViewModel.init)
                }
                DispatchQueue.main.async {
                    completion()
                }
            }
            
        }else{
            // database
            
        }
        
        

    }
    
    
}
