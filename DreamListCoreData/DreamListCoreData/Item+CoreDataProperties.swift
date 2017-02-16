//
//  Item+CoreDataProperties.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var title: String?
    @NSManaged public var descrip: String?
    @NSManaged public var cost: Double
    @NSManaged public var createdDate: NSDate?
    @NSManaged public var targetDate: NSDate?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toUser: User?

}
