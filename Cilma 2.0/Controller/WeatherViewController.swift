//
//  WeatherViewController.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 7/22/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import UIKit
import SideMenu

class WeatherViewController: UIViewController {
    
    private let menu = SideMenuNavigationController(rootViewController: UIViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        
    }
    
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        present(menu, animated: true)
    }
    
}

//MARK: - UITableViewController
class SideMenuTableView: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuTableView.self, forCellReuseIdentifier: K.menuCellIdentifier)
    }
    
    var menuItems = ["Profile",
    "Log Out",]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.menuCellIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        
        return cell
    }
    
}


//MARK: - Navigation Controller

extension WeatherViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
