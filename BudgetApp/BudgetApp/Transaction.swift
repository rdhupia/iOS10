//
//  Transaction.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-07-08.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import Foundation

class Transaction {
    var amount: String?
    var date: String?
    var descrip: String?
    var category: String?
    var transactionType: String?
    
    init(amount: String?, date: String?, descrip: String?, category: String?, transactionType: String = "expense") {
        self.amount = amount
        self.date = date
        self.descrip = descrip
        self.category = category
        self.transactionType = transactionType
        
    }
}
