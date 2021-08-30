//
//  WeatherViewController.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 7/22/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

//MARK: - WeatherViewController

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var tempUnitLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideMenuTableView = SideMenuTableView()
        sideMenuTableView.delegate = self
        
        menu = SideMenuNavigationController(rootViewController: sideMenuTableView)
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        
    }
    
    
    @IBAction func menuButtonPressed(_ sender: UIButton){
        present(menu!, animated: true)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
    }
    
    
}
//MARK: - SideMenuControllerDelegate

protocol SideMenuControllerDelegate {
    func didSelectMenuItem(named: String)
}

extension WeatherViewController: SideMenuControllerDelegate {
    func didSelectMenuItem(named menuItem: String) {
        if menuItem == K.SideMenuItem.logout {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("User has signed out")
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            menu?.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}


//MARK: - SideMenuTableView

class SideMenuTableView: UITableViewController {
    
    var delegate: SideMenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.menuCellIdentifier)
    }
    
    var menuItems = [K.SideMenuItem.profile,
                     K.SideMenuItem.settings,
                     K.SideMenuItem.logout,]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.menuCellIdentifier, for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
        
        
    }
    
}


//MARK: - NavigationController

extension WeatherViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
