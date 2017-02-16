//
//  User+CoreDataProperties.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var username: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var balance: Double
    @NSManaged public var toExpense: NSSet?
    @NSManaged public var toIncome: NSSet?
    @NSManaged public var toImage: NSSet?
    @NSManaged public var toItem: NSSet?

}

// MARK: Generated accessors for toExpense
extension User {

    @objc(addToExpenseObject:)
    @NSManaged public func addToToExpense(_ value: Expense)

    @objc(removeToExpenseObject:)
    @NSManaged public func removeFromToExpense(_ value: Expense)

    @objc(addToExpense:)
    @NSManaged public func addToToExpense(_ values: NSSet)

    @objc(removeToExpense:)
    @NSManaged public func removeFromToExpense(_ values: NSSet)

}

// MARK: Generated accessors for toIncome
extension User {

    @objc(addToIncomeObject:)
    @NSManaged public func addToToIncome(_ value: Income)

    @objc(removeToIncomeObject:)
    @NSManaged public func removeFromToIncome(_ value: Income)

    @objc(addToIncome:)
    @NSManaged public func addToToIncome(_ values: NSSet)

    @objc(removeToIncome:)
    @NSManaged public func removeFromToIncome(_ values: NSSet)

}

// MARK: Generated accessors for toImage
extension User {

    @objc(addToImageObject:)
    @NSManaged public func addToToImage(_ value: Image)

    @objc(removeToImageObject:)
    @NSManaged public func removeFromToImage(_ value: Image)

    @objc(addToImage:)
    @NSManaged public func addToToImage(_ values: NSSet)

    @objc(removeToImage:)
    @NSManaged public func removeFromToImage(_ values: NSSet)

}

// MARK: Generated accessors for toItem
extension User {

    @objc(addToItemObject:)
    @NSManaged public func addToToItem(_ value: Item)

    @objc(removeToItemObject:)
    @NSManaged public func removeFromToItem(_ value: Item)

    @objc(addToItem:)
    @NSManaged public func addToToItem(_ values: NSSet)

    @objc(removeToItem:)
    @NSManaged public func removeFromToItem(_ values: NSSet)

}
