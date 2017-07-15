//
//  AddExpenseVC.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-18.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import Firebase

class AddExpenseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var typeExpenseTextBox: UITextField!
    @IBOutlet weak var dateDisplayBtn: UIButton!

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descripTextField: UITextField!
    
    @IBOutlet weak var typeExpenseDropDown: UIPickerView!
    @IBOutlet weak var datePickerDropDown: UIDatePicker!
    @IBOutlet weak var dateSelectedBtn: UIButton!
    @IBOutlet weak var dateSelectedBtnBgView: UIView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var typesOfExpenses = ["Rent", "Mortgage(s)", "Condo fee", "Home nsurance", "Utilities", "Loan payment", "Insurance payments", "Bank fees", "Streaming services", "Clothes", "Entertainment", "Eat Out", "Groceries", "Gifts", "Maintenance", "Gas/Parking", "Local transit", "Travel", "Personal care", "Day Care", "Subscriptions", "Others"]

    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get instance of FIRDatabase reference to read and write
        ref = FIRDatabase.database().reference()

        self.typeExpenseDropDown.dataSource = self
        self.typeExpenseDropDown.delegate = self
        
        self.amountTextField.delegate = self
        self.descripTextField.delegate = self
        self.typeExpenseTextBox.delegate = self

        showOrHideDatePicker(hideDatePicker: true)
        
        formatAndSetDate()
        var dateComponents = self.dateDisplayBtn.titleLabel?.text?.components(separatedBy: "/")
        
        // Retrieve transactions and listen for changes
        
        if dateComponents?[0] != nil && dateComponents?[1] != nil {
            print(dateComponents?[0] ?? "YYYY")
            print(dateComponents?[1] ?? "mm")
            
            let month = dateComponents?[1]
            
            databaseHandle = (ref?.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("transactions").child((dateComponents?[0])!).child(month!).observe(.value, with: { (snapshot) in
            
              
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
                        
                        let expenseTransactionObject = Transaction(amount: transactionAmount as! String?, date: transactionDate as! String?, descrip: transactionDescrip as! String?, category: transactionCategory as! String?)
                        
                        self.transactions.append(expenseTransactionObject)
                    }
                    
                }
                
                self.myTableView.reloadData()
            
            }))
        }
    }
    
    // Implementing UITableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (transactions.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddExpenseVCTableViewCell
        
        cell.amountField.text = "$ "+transactions[indexPath.row].amount!
        cell.categoryField.text = transactions[indexPath.row].category
        cell.dateField.text = transactions[indexPath.row].date?.components(separatedBy: "/")[2]
        cell.descripField.text = transactions[indexPath.row].descrip
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            transactions.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }

    // Implementing UIPickerView protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typesOfExpenses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typesOfExpenses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeExpenseTextBox.text = self.typesOfExpenses[row]
        self.typeExpenseDropDown.isHidden = true
        self.myTableView.isHidden = false
    }
    
    // Implementing text field should return delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // Manipulating text field to show picker value
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.typeExpenseTextBox {
            showOrHideDatePicker(hideDatePicker: true)
            self.typeExpenseDropDown.isHidden = false
            self.myTableView.isHidden = true
            self.view.endEditing(true)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showOrHideDatePicker(hideDatePicker: true)
        self.typeExpenseDropDown.isHidden = false
        self.myTableView.isHidden = true
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    // Add Expense Action
    @IBAction func addExpenseBtnPressed(_ sender: UIButton) {
        if ( amountTextField.text != "" && dateDisplayBtn.titleLabel?.text != "" )
        {
            var dateComponents = self.dateDisplayBtn.titleLabel?.text?.components(separatedBy: "/")
            self.ref?.child("users").child(FIRAuth.auth()!.currentUser!.uid).child("transactions").child((dateComponents?[0])!).child((dateComponents?[1])!).childByAutoId().setValue(["date": dateDisplayBtn.titleLabel?.text, "amount": amountTextField.text, "description": descripTextField.text, "category": typeExpenseTextBox.text])

            amountTextField.text = ""
            descripTextField.text = ""
            typeExpenseTextBox.text = ""
        }
        myTableView.reloadData()
    }
    
    // Manipulating date display button
    @IBAction func dateDisplayBtnPressed(_ sender: Any) {
        if self.datePickerDropDown.isHidden {
            self.typeExpenseDropDown.isHidden = true
            self.myTableView.isHidden = true
            showOrHideDatePicker(hideDatePicker: false)
        } else {
              showOrHideDatePicker(hideDatePicker: true)
            self.myTableView.isHidden = false
        }
    }
    
    
    // Date picker Action
    @IBAction func datePickerValueChanged(_ sender: Any) {
        formatAndSetDate()
    }
    
    @IBAction func dateSelectedBtnPressed(_ sender: Any) {
          showOrHideDatePicker(hideDatePicker: true)
          self.myTableView.isHidden = false
          self.viewDidLoad()
    }
    
    func formatAndSetDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        
        // Set button's title to the date selected
        self.dateDisplayBtn.setTitle(formatter.string(from: datePickerDropDown.date), for: .normal)
    }
    
    func showOrHideDatePicker( hideDatePicker: Bool) {
        self.datePickerDropDown.isHidden = hideDatePicker
        self.dateSelectedBtn.isHidden = hideDatePicker
        self.dateSelectedBtnBgView.isHidden = hideDatePicker
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
