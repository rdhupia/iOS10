//
//  AddIncomeVC.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-07-11.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import Firebase

class AddIncomeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

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
    
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get instance of FIRDatabase reference to read and write
        ref = FIRDatabase.database().reference()
        
        self.incomeTypePicker.dataSource = self
        self.incomeTypePicker.delegate = self
        
        self.incomeTextField.delegate = self
        self.incomeDescripTextField.delegate = self
        self.incomeTypeTextField.delegate = self
        
        self.incomeTableView.delegate = self
        self.incomeTableView.dataSource = self
        
        showOrHideDatePicker(hideDatePicker: true)
        
        formatAndSetDate()
        var dateComponents = self.datePickerIncome.titleLabel?.text?.components(separatedBy: "/")
        
        // Retrieve transactions and listen for changes
        
        if dateComponents?[0] != nil && dateComponents?[1] != nil {
            print(dateComponents?[0] ?? "YYYY")
            print(dateComponents?[1] ?? "mm")
            
            let month = dateComponents?[1]
            
            databaseHandle = (ref?.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("incomes").child((dateComponents?[0])!).child(month!).observe(.value, with: { (snapshot) in
                
                
                // Take the value from the snapshot and add it to the list array
                self.transactions.removeAll()
                if snapshot.childrenCount > 0 {
                    
                    print(snapshot)
                    
                    for month in snapshot.children.allObjects as![FIRDataSnapshot] {
                        let transactionObject = month.value as? [String: AnyObject]
                        let transactionAmount = transactionObject?["amount"]
                        let transactionDate = transactionObject?["date"]
                        let transactionDescrip = transactionObject?["description"]
                        let transactionCategory = transactionObject?["category"]
                        
                        let incomeTransactionObject = Transaction(amount: transactionAmount as! String?, date: transactionDate as! String?, descrip: transactionDescrip as! String?, category: transactionCategory as! String?, transactionType: "income")
                        print(transactionAmount ?? 0)
                        self.transactions.append(incomeTransactionObject)
                        print(self.transactions.count)
                    }
                    
                }
                
                self.incomeTableView.reloadData()
                
            }))
        }
        
    }
    
    // Implementing UITableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (transactions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! AddIncomeVCTableViewCell
        
        cell.incomeAmountField.text = "$ "+transactions[indexPath.row].amount!
        cell.incomeCategoryField.text = transactions[indexPath.row].category
        cell.incomeDateField.text = transactions[indexPath.row].date?.components(separatedBy: "/")[2]
        cell.incomeDescripField.text = transactions[indexPath.row].descrip
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            transactions.remove(at: indexPath.row)
            incomeTableView.reloadData()
        }
    }
    
    // Implementing UIPickerView protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typesOfIncomes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typesOfIncomes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.incomeTypeTextField.text = self.typesOfIncomes[row]
        self.incomeTypePicker.isHidden = true
        self.incomeTableView.isHidden = false
    }

    
    // Implementing text field should return delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // Manipulating text field to show picker value
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.incomeTypeTextField {
            showOrHideDatePicker(hideDatePicker: true)
            self.incomeTypePicker.isHidden = false
            self.incomeTableView.isHidden = true
            self.view.endEditing(true)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showOrHideDatePicker(hideDatePicker: true)
        self.incomeTypePicker.isHidden = false
        self.incomeTableView.isHidden = true
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        incomeTableView.reloadData()
    }
    
    // Add Income pressed
    @IBAction func addIncomeBtnPressed(_ sender: UIButton) {
        if ( incomeTextField.text != "" && datePickerIncome.titleLabel?.text != "" )
        {
            var dateComponents = self.datePickerIncome.titleLabel?.text?.components(separatedBy: "/")
            self.ref?.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("incomes").child((dateComponents?[0])!).child((dateComponents?[1])!).childByAutoId().setValue(["date": datePickerIncome.titleLabel?.text, "amount": incomeTextField.text, "description": incomeDescripTextField.text, "category": incomeTypeTextField.text])
            
            incomeTextField.text = ""
            incomeDescripTextField.text = ""
            incomeTypeTextField.text = ""
        }
        incomeTableView.reloadData()
    }
    
    // Date picker pressed
    @IBAction func datePickerIcomePressed(_ sender: UIButton) {
        if self.incomeDatePicker.isHidden {
            self.incomeTypePicker.isHidden = true
            self.incomeTableView.isHidden = true
            showOrHideDatePicker(hideDatePicker: false)
        } else {
            showOrHideDatePicker(hideDatePicker: true)
            self.incomeTableView.isHidden = false
        }
    }
    
    // Date picker Action
    @IBAction func datePickerValueChanged(_ sender: Any) {
        formatAndSetDate()
    }
    
    func formatAndSetDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        
        // Set button's title to the date selected
        self.datePickerIncome.setTitle(formatter.string(from: incomeDatePicker.date), for: .normal)
    }
    
    func showOrHideDatePicker( hideDatePicker: Bool) {
        self.incomeDatePicker.isHidden = hideDatePicker
        self.incomeDateSelectedBtn.isHidden = hideDatePicker
        self.incomeDateSelectedBtnBgView.isHidden = hideDatePicker
    }
    
    // Date Selected button pressed
    @IBAction func incomeDateSelectedBtnPressed(_ sender: UIButton) {
        showOrHideDatePicker(hideDatePicker: true)
        self.incomeTableView.isHidden = false
        self.viewDidLoad()
    }
    
}
