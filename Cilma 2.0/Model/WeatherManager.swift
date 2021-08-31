//
//  WeatherManager.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 7/31/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=Dallas&appid=52b4d92541816a7d8989ea442c753b31"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)?q=\(cityName)"
    }
    
    func performRequest(urlString: String){
        //Create URL
        if let url = URL(string: urlString){
            //Create the URLSession
            let session = URLSession(configuration: .default)
            //Give the URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    let dataString = String(data: Data, encoding: .utf8)
                }
            }
            //Execute the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    
    
}
