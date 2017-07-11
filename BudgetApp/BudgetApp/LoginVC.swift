//
//  LoginVC.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-20.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    /* Views and Fields */
    
    // Input container
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Give corner radius to inputs container
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
    // Register Button
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 41, g: 163, b: 41)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Give button rounded corners
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        // Add a target / action
        button.addTarget(self, action: #selector(handleLoignRegister), for: .touchUpInside)
        
        return button
    }()
    
    // Text Fields
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // Images
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "house_money")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Login Controls
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["Login", "Register"])
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.tintColor = UIColor(r: 41, g: 163, b: 41)
        seg.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        seg.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .normal)
        seg.selectedSegmentIndex = 1
        
        // Add target
        seg.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return seg
    }()
    
    
    // Handle Actions
    func handleLoignRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        // Getting optional values within guard statement
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Input values not valid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            // Successfully logged in user
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func handleRegister() {
        
        // Getting optional values within guard statement
        guard let email = emailTextField.text, let password = passwordTextField.text, let username = nameTextField.text else {
            print("Input values not valid")
            return
        }
        
        // MARK: FIREBASE Call authentication function from Firebase
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
           
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // user aunthenticated successfully
            print("User authenticated successfully")
            
            // Add user to Firebase DB
            let ref = FIRDatabase.database().reference(fromURL: "https://budgetapp-bf7da.firebaseio.com/")
            
            // Child reference
            let usersRef = ref.child("users").child(uid)
            
            let values = ["username": username, "email": email]
            usersRef.updateChildValues(values, withCompletionBlock: { (error2, ref) in
                
                if error2 != nil {
                    print(error2!)
                    return
                }
                
                print("User saved to Firebase Database")
                
                self.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func handleLoginRegisterChange() {
        let titleForLoginRegisterBtn = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(titleForLoginRegisterBtn, for: .normal)
        
        nameTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor?.isActive = false
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            
            // Change height of inputsContainerView
            inputsContainerViewHeightAnchor?.constant = 100
            
            // Change height of nameTextField
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            
            // Remove nameTextField's placeholder
            nameTextField.placeholder = ""
            
            // Change emailTextField height
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            
            // Change passwordTextField height
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            
        } else {
            inputsContainerViewHeightAnchor?.constant = 150
            
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            
            nameTextField.placeholder = "Username"
            
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        }
        
        nameTextFieldHeightAnchor?.isActive = true
        emailTextFieldHeightAnchor?.isActive = true
        passwordTextFieldHeightAnchor?.isActive = true
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Convenience method in ExtensionUIColor file
        // view.backgroundColor = UIColor(r: 159, g: 203, b: 1)
        view.backgroundColor = UIColor(r: 174, g: 221, b: 1)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(logoImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupInputsViewContainer()
        setupLoginRegisterButton()
        setupLogoImageView()
        setupLoginRegisterSegmentedControl()
        
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputsViewContainer() {
        // need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        // Add name text field subview
        inputsContainerView.addSubview(nameTextField)
        
        // need x, y, width, height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        // Add name text field seperator view
        inputsContainerView.addSubview(nameSeperatorView)
        
        // need x, y, width, height constraints
        nameSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        // Add name text field subview
        inputsContainerView.addSubview(emailTextField)
        
        // need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeperatorView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        // Add name text field seperator view
        inputsContainerView.addSubview(emailSeperatorView)
        
        // need x, y, width, height constraints
        emailSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        // Add name text field subview
        inputsContainerView.addSubview(passwordTextField)
        
        // need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeperatorView.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    func setupLoginRegisterButton() {
        // need x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupLogoImageView() {
        // need x, y, width, height constraints
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupLoginRegisterSegmentedControl() {
        // need x, y, width, height constraints
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
    

   
}



















