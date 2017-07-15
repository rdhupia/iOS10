//
//  AddIncomeVC.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-07-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import Firebase

class AddIncomeVC: UIViewController {

    @IBOutlet weak var datePickerIncome: UIButton!
    @IBOutlet weak var addIncomeBtn: UIButton!
    @IBOutlet weak var incomeDateSelectedBtn: UIButton!
    
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var incomeDescripTextField: UITextField!
    @IBOutlet weak var incomeTypeTextField: UITextField!
    
    @IBOutlet weak var incomeTypePicker: UIPickerView!
    @IBOutlet weak var incomeDatePicker: UIDatePicker!
    
    @IBOutlet weak var incomeDateSelectedBtnBgView: UIView!
    @IBOutlet weak var incomeTableView: UITableView!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var typesOfIncomes = ["Salary", "Bonus", "Commission", "Interests", "Rent", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // Date picker pressed
    @IBAction func datePickerIcomePressed(_ sender: UIButton) {
    }
    
    // Add Income pressed
    @IBAction func addIncomeBtnPressed(_ sender: UIButton) {
    }

    // Date Selected button pressed
    @IBAction func incomeDateSelectedBtnPressed(_ sender: UIButton) {
    }
    
}
