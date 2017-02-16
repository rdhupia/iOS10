//
//  Expense+CoreDataProperties.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense");
    }

    @NSManaged public var expenseName: String?
    @NSManaged public var expenseType: String?
    @NSManaged public var expenseAmount: Double
    @NSManaged public var expenseDate: NSDate?
    @NSManaged public var toUser: User?

}
