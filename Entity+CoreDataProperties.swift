//
//  Entity+CoreDataProperties.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/09.
//
//

import Foundation
import CoreData


extension Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }
    @NSManaged public var mapID: String?
    @NSManaged public var title: String?
    @NSManaged public var placeName: String?
    @NSManaged public var adress: String?
    @NSManaged public var latitude: Double
    @NSManaged public var logitude: Double
    @NSManaged public var isFavorite: Bool

}







