//
//  ViewController.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-07.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    
    @IBOutlet weak var addIncomeBtn: UIButton!
    @IBOutlet weak var addExpenseBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = FIRDatabase.database().reference(fromURL: "https://budgetapp-bf7da.firebaseio.com/")
//        ref.updateChildValues(["someValue": 1234])
        
        // User is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLoggedOutUser), with: nil, afterDelay: 0)
        }
    }

    // Add button toggles, gives option to add income and expense
    @IBAction func AddPressed(_ sender: UIButton) {
        
        if addBtn.titleLabel!.text == "◉" {
            addIncomeBtn.isHidden = false
            addExpenseBtn.isHidden = false
            addBtn.setTitle("+", for: .normal)
            addBtn.backgroundColor = UIColor.white
        } else {
            addIncomeBtn.isHidden = true
            addExpenseBtn.isHidden = true
            addBtn.setTitle("◉", for: .normal)
            
        }
        
    }
   
    // Handle logout: User clicks logout
    @IBAction func logoutBtnPressed(_ sender: UIBarButtonItem) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        // Go to Login/Registration screen
        present(LoginVC(), animated: true, completion: nil)
    }

    // Handle logout: No user logged in (without animation)
    func handleLoggedOutUser() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        // Go to Login/Registration screen
        present(LoginVC(), animated: false, completion: nil)
    }
}
























