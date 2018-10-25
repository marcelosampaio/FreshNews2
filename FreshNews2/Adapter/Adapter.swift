//
//  Adapter.swift
//  FreshNews2
//
//  Created by Marcelo on 24/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import CoreData

class Adapter {
    
    func adaptFromViewModelToBusinessModel(articleViewModel: ArticleViewModel) -> Article {
        
        let article = Article(dictionary: NSDictionary())
        article.title = articleViewModel.title!
        article.description = articleViewModel.description!
        article.author = articleViewModel.author!
        article.url = articleViewModel.url!
        article.urlToImage = articleViewModel.urlToImage!
        article.publishedAt = articleViewModel.publishedAt!
        
        return article
    }
    
    func adaptFromViewModelToCoreDataModel(articleViewModel: ArticleViewModel, context: NSManagedObjectContext) -> FavoriteArticle {
        
        let favoriteArticle = FavoriteArticle(context: context)
        favoriteArticle.title = articleViewModel.title!
        favoriteArticle.articleDescription = articleViewModel.description!
        favoriteArticle.author = articleViewModel.author!
        favoriteArticle.url = articleViewModel.url!
        favoriteArticle.urlToImage = articleViewModel.urlToImage!
        favoriteArticle.publishedAt = articleViewModel.publishedAt!
        
        return favoriteArticle
    }
    
    func adaptFromBusisnessModelToCoreDataModel(article: Article) -> FavoriteArticle {
        
        let favoriteArticle = FavoriteArticle()
        favoriteArticle.title = article.title
        favoriteArticle.articleDescription = article.description
        favoriteArticle.author = article.author
        favoriteArticle.url = article.url
        favoriteArticle.urlToImage = article.urlToImage

        return favoriteArticle
        
    }
    
}
