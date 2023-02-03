//
//  SavedNews+CoreDataProperties.swift
//  
//
//  Created by Артем Томило on 3.02.23.
//
//

import Foundation
import CoreData


extension SavedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedNews> {
        return NSFetchRequest<SavedNews>(entityName: "SavedNews")
    }

    @NSManaged public var title: String
    @NSManaged public var text: String
    @NSManaged public var date: String
    @NSManaged public var id: String
    @NSManaged public var pathForImage: String?

}
