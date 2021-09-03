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
import CoreLocation

//MARK: - WeatherViewController

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempUnitLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    
    var menu: SideMenuNavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        //Side Menu Initialization/Delegation
        
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
    
}
//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        textFieldDidEndEditing(searchTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(searchTextField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (searchTextField.text != nil){
            return true
        }
        else{
            searchTextField.text = "Please enter something here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let safeText = searchTextField.text {
            weatherManager.fetchWeather(cityName: safeText)
        }
    }
    
    
}

//MARK: WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.weatherIcon.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
        
    }
    
    func didFailWithError(error e: Error) {
        if e.localizedDescription != "Missing or insufficient permissions."{
            let registerAlert = UIAlertController(title: "Error", message: "\(e.localizedDescription)", preferredStyle: .alert)
            registerAlert.addAction(UIAlertAction(title: "Understood", style: .cancel, handler: nil))
            self.present(registerAlert, animated: true)
        }
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


//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
