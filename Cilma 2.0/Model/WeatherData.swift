//
//  WeatherData.swift
//  Cilma 2.0
//
//  Created by Shoaib Huq on 7/31/20.
//  Copyright © 2020 Shoaib Huq. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
