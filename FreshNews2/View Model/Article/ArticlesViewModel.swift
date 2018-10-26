//
//  ArticlesViewModel.swift
//  FreshNews2
//
//  Created by Marcelo on 21/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class ArticlesViewModel {
    
    // public
    public var articles : [ArticleViewModel] = [ArticleViewModel]()
    
    // private
    private var favoriteArticles : [FavoriteArticle]?
    private var webService = WebService()
    private var databaseService = FavoriteService(moc: AppSettings.standard.moc!)
    private var adapter = Adapter()
    
    
    // --
    init(provider: ProviderType, sourceId: String, completion: @escaping () -> ()) {
        
        if provider == ProviderType.web {
            //web
            webService.getNews(sourceId: sourceId) { (resultArticles) in
                if resultArticles.count > 0 {
                    self.articles = resultArticles.map(ArticleViewModel.init)
                }
                // completion
                DispatchQueue.main.async {
                    completion()
                }
            }
            
        }else{
            // database
            self.favoriteArticles = databaseService.getAllArticles()
            for favoriteArticle in self.favoriteArticles! {
                let vmArticle = self.adapter.adaptFromCoreDataModelToViewModel(favoriteArticle: favoriteArticle)
                articles.append(vmArticle)
            }
            // completion
            DispatchQueue.main.async {
                completion()
            }
        }
        
        

    }
    
    
}
