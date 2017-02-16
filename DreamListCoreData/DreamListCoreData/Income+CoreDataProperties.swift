//
//  Income+CoreDataProperties.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income");
    }

    @NSManaged public var incomeName: String?
    @NSManaged public var incomeType: String?
    @NSManaged public var incomeAmount: Double
    @NSManaged public var incomeDate: NSDate?
    @NSManaged public var toUser: User?

}
