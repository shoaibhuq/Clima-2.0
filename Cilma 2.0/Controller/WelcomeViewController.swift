//
//  ViewController.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 3/23/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}







//MARK: - Navigation Controller

extension WelcomeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

    }

    
}
