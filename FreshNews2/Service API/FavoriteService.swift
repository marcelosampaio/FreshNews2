//
//  FavoriteService.swift
//  FreshNews2
//
//  Created by Marcelo on 24/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import CoreData

typealias FavoriteArticleHandler = (Bool, [FavoriteArticle]) -> ()

class FavoriteService {
    
    private let moc : NSManagedObjectContext
    private var favoriteArticles = [FavoriteArticle]()  // NSMAnagedObject of core data
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - Data
    public func addFavoriteArticle(_ article: Article, completion: FavoriteArticleHandler) {
        
        let favoriteArticle = FavoriteArticle(context: moc)
        favoriteArticle.urlToImage = article.urlToImage
        favoriteArticle.articleDescription = article.description
        favoriteArticle.title = article.title
        favoriteArticle.publishedAt = article.publishedAt
        favoriteArticle.author = article.author
        favoriteArticle.url = article.url

        favoriteArticles.append(favoriteArticle)
        completion(true, favoriteArticles)
            

        save()
        
    }
    
    public func getAllArticles() -> [FavoriteArticle]? {
        
        let sortByDate = NSSortDescriptor(key: "publishedAt", ascending: false)
        
        let sortDescriptors = [sortByDate]
        
        
        let request : NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        do {
            favoriteArticles = try moc.fetch(request)
            return favoriteArticles
        } catch let error as NSError {
            print("Error getting students: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    public func delete(favoriteArticle: FavoriteArticle) {

        favoriteArticles = favoriteArticles.filter({ $0 != favoriteArticle})
        moc.delete(favoriteArticle)
        
        save()
        
    }
    

    
//    private func favoriteArticleExists(url: String) -> FavoriteArticle? {
//
//        let request : NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
//        request.predicate = NSPredicate(format: "url = %@", url)
//        let favoriteArticle : FavoriteArticle?
//        do {
//            let result = try moc.fetch(request)
//            print("result: \(result)")
////            lesson = result.isEmpty ? addNewLesson(type: type) : result.first
//        }
//        catch let error as NSError  {
//            print("Error getting lesson: \(error.localizedDescription)")
//        }
//
//        return favoriteArticle
//
//    }
    
    
    // MARK: - Persistence
    private func save() {
//        let appDelegate = AppDelegate()
//        appDelegate.saveContext()
        
        do {
            try moc.save()
        }
        catch let error as NSError {
            print("Error saving student: \(error.localizedDescription)")
        }
    }
    
    
}
