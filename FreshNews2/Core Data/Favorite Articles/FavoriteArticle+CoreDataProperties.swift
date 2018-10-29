//
//  FavoriteArticle+CoreDataProperties.swift
//  
//
//  Created by Marcelo on 24/10/18.
//
//

import Foundation
import CoreData


extension FavoriteArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticle> {
        return NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
    }

    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var author: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?

}
