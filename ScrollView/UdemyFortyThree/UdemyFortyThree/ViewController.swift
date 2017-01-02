//
//  ViewController.swift
//  UdemyFortyThree
//
//  Created by Ravideep Dhupia on 2016-12-29.
//  Copyright © 2016 Ravideep Dhupia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // Outlets
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyPickerBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    let currencies: [String] = ["US Dollar", "Australian Dollar", "Canadian Dollar", "Indian Rupee", "Singapore Dollar", "UK Pound"]

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Actions
    @IBAction func currencyBtnPressed(_ sender: Any) {
        currencyPicker.isHidden = false
        registerBtn.isHidden = true
    }
    @IBAction func registerBtnPressed(_ sender: Any) {
        
    }
  
    // Conforming to protocols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {      // columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyPickerBtn.setTitle(currencies[row], for: UIControlState())
        currencyPicker.isHidden = true
        registerBtn.isHidden = false
    }
}

