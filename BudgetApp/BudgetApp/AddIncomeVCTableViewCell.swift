//
//  AddIncomeVCTableViewCell.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-07-15.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class AddIncomeVCTableViewCell: UITableViewCell {

    
    @IBOutlet weak var incomeDateField: UILabel!
    @IBOutlet weak var incomeAmountField: UILabel!
    @IBOutlet weak var incomeCategoryField: UILabel!
    @IBOutlet weak var incomeDescripField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
