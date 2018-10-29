//
//  Country+CoreDataProperties.swift
//  
//
//  Created by Marcelo on 29/10/18.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var continent: Continent?

}
