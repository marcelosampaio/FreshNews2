//
//  AppSettings.swift
//  FreshNews2
//
//  Created by Marcelo on 26/10/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import CoreData

private let sharedSingleton = AppSettings()

class AppSettings {

    public var moc : NSManagedObjectContext?
    public var genericString = String()
    
    class var standard: AppSettings {
        return sharedSingleton
    }
    
}
