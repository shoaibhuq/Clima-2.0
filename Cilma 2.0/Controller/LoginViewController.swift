//
//  UViewController.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 3/24/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    self.presentError(e)
                    
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            
            }
        }
        
    }
    
    
    // MARK: - Navigation

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Error Handling

extension LoginViewController {
    func presentError(_ e: Error) {
        if e.localizedDescription != "Missing or insufficient permissions."{
            let registerAlert = UIAlertController(title: "Error", message: "\(e.localizedDescription)", preferredStyle: .alert)
            registerAlert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(registerAlert, animated: true)
        }
    }
}

