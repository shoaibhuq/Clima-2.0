//
//  UViewController.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 3/24/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.presentError(e)
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
            
        }
        
    }
    
}


//MARK: - Error Handling

extension RegisterViewController {
    func presentError(_ e: Error) {
        if e.localizedDescription != "Missing or insufficient permissions."{
            let registerAlert = UIAlertController(title: "Error", message: "\(e.localizedDescription)", preferredStyle: .alert)
            registerAlert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(registerAlert, animated: true)
        }
    }
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Textfield works")
    }
    
    
    
}
