//
//  WeatherData.swift
//  WeatherRun
//
//  Created by Aniket Kumar on 01/07/22.
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
