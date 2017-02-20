//
//  AddExpenseVC.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-18.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

class AddExpenseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var typeExpenseTextBox: UITextField!
    @IBOutlet weak var dateDisplayBtn: UIButton!
    
    @IBOutlet weak var typeExpenseDropDown: UIPickerView!
    @IBOutlet weak var datePickerDropDown: UIDatePicker!
    @IBOutlet weak var dateSelectedBtn: UIButton!
    @IBOutlet weak var dateSelectedBtnBgView: UIView!
    
    
    var typesOfExpenses = ["Rent", "Mortgage(s)", "Condo fee", "House/Tenant insurance", "Utility Bills", "Lease/Loan payment", "Vehicle insurance", "Life/Health insurance", "Bank/Credit card fees", "Streaming services", "Clothing/Shoes", "Eat out/Entertainment", "Groceries", "Gifts", "Vehicle Maintenance", "Home Maintenance", "Gas/Parking", "Local transit", "Travel (Flights, hotels)", "Personal care", "Day Care", "Subscriptions", "Miscellaneous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeExpenseDropDown.dataSource = self
        self.typeExpenseDropDown.delegate = self

        showOrHideDatePicker(hideDatePicker: true)
        
        formatAndSetDate()
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
    }
    
    // Manipulating text field to show picker value
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.typeExpenseTextBox {
            showOrHideDatePicker(hideDatePicker: true)
            self.typeExpenseDropDown.isHidden = false
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showOrHideDatePicker(hideDatePicker: true)
        self.typeExpenseDropDown.isHidden = false
        return true
    }
    
    // Manipulating date display button
    @IBAction func dateDisplayBtnPressed(_ sender: Any) {
        if self.datePickerDropDown.isHidden {
            self.typeExpenseDropDown.isHidden = true
            showOrHideDatePicker(hideDatePicker: false)
        } else {
              showOrHideDatePicker(hideDatePicker: true)
        }
    }
    
    
    // Date picker Action
    @IBAction func datePickerValueChanged(_ sender: Any) {
        formatAndSetDate()
    }
    
    @IBAction func dateSelectedBtnPressed(_ sender: Any) {
          showOrHideDatePicker(hideDatePicker: true)
    }
    
    func formatAndSetDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        
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
