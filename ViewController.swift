//
//  ViewController.swift
//  Laura Jane
//
//  Created by Takunda on 04/03/2018.
//  Copyright © 2018 ZimApps. All rights reserved.
//


import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                self.dismiss(animated: false, completion: nil)
            } else {
                
            }
        })
    
   /*
        
        class WelcomeViewController: UIViewController {
            
            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                
                FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                    if let _ = user {
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        
                    }
                })
            }
            
            override var prefersStatusBarHidden: Bool {
                return true
            }
        }*/
        
        emailTextField.becomeFirstResponder()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginDidTap()
    {
        if emailTextField.text != "" && (passwordTextField.text?.characters.count)! > 6 {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (firUser, error) in
                if let error = error {
                    self.alert(title: "Oops!", message: error.localizedDescription, buttonTitle: "OK")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }

    func alert(title: String, message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func backDidTap(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            loginDidTap()
        }
        
        return true
    }
}

