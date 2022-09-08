//
//  DailyForecastWeatherResponse.swift
//  NetworkAPI
//
//  Created by cagla copuroglu on 7.09.2022.
//

import Foundation

public struct DailyForecastWeatherResponse: Codable {
     let city: City?
     let cod: String?
     let message: Double?
     let cnt: Int?
     let list: [List]?
}
