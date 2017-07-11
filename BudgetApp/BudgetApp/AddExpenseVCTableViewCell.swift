//
//  AddExpenseVCTableViewCell.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-07-07.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class AddExpenseVCTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var amountField: UILabel!
    @IBOutlet weak var descripField: UILabel!
    @IBOutlet weak var categoryField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
