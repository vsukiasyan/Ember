//
//  LoginViewController.swift
//  Ember
//
//  Created by Vic Sukiasyan on 5/10/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginSignupBtn: UIButton!
    @IBOutlet weak var changeLoginSignupBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    var signUpMode = false

    override func viewDidLoad() {
        super.viewDidLoad()

        errorLbl.isHidden = true
        
    }
    
    @IBAction func loginSignupTapped(_ sender: Any) {
        if signUpMode {
            let user = PFUser()
            
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground(block: { (success, error) in
                if error != nil {
                    var errorMessage = "Signup failed - Try again"
                    if let newError = error as NSError? {
                        if let detailError = newError.userInfo["error"] as? String {
                            errorMessage = detailError
                        }
                    }
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = errorMessage
                } else {
                    print("Sign up successful")
                }
            })
        } else {
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!, block: { (user, error) in
                if error != nil {
                    var errorMessage = "Login failed - Try again"
                    if let newError = error as NSError? {
                        if let detailError = newError.userInfo["error"] as? String {
                            errorMessage = detailError
                        }
                    }
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = errorMessage
                } else {
                    print("Login up successful")
                }
            })
        }
        
    }
    
    
    @IBAction func changeLoginSignupTapped(_ sender: Any) {
        if signUpMode {
            loginSignupBtn.setTitle("Login", for: .normal)
            changeLoginSignupBtn.setTitle("Sign Up", for: .normal)
            signUpMode = false
        } else {
            loginSignupBtn.setTitle("Sign Up", for: .normal)
            changeLoginSignupBtn.setTitle("Login", for: .normal)
            signUpMode = true
        }
        
    }
    
 

}
