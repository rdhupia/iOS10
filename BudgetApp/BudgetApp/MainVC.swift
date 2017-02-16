//
//  ViewController.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-07.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    @IBOutlet weak var addIncomeBtn: UIButton!
    @IBOutlet weak var addExpenseBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Add button toggles, gives option to add income and expense
    @IBAction func AddPressed(_ sender: UIButton) {
        
        if addBtn.titleLabel!.text == "+" {
            addIncomeBtn.isHidden = false
            addExpenseBtn.isHidden = false
            addBtn.setTitle("◉", for: .normal)
            addBtn.backgroundColor = UIColor.white
        } else {
            addIncomeBtn.isHidden = true
            addExpenseBtn.isHidden = true
            addBtn.setTitle("+", for: .normal)
            
        }
        
    }
   


}

