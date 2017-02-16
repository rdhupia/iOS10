//
//  User+CoreDataClass.swift
//  DreamListCoreData
//
//  Created by Ravideep Dhupia on 2017-01-22.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    // When item is created, func will be called
    public override func awakeFromInsert() {
        
        super.awakeFromInsert() // call super class
        
        // Assign current date to createdDate attribute
        self.balance = 0
    }
}
