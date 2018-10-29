//
//  Continent+CoreDataProperties.swift
//  
//
//  Created by Marcelo on 29/10/18.
//
//

import Foundation
import CoreData


extension Continent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Continent> {
        return NSFetchRequest<Continent>(entityName: "Continent")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var countries: NSSet?

}

// MARK: Generated accessors for countries
extension Continent {

    @objc(addCountriesObject:)
    @NSManaged public func addToCountries(_ value: Country)

    @objc(removeCountriesObject:)
    @NSManaged public func removeFromCountries(_ value: Country)

    @objc(addCountries:)
    @NSManaged public func addToCountries(_ values: NSSet)

    @objc(removeCountries:)
    @NSManaged public func removeFromCountries(_ values: NSSet)

}
