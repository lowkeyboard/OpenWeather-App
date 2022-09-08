//
//  DailyForecastWeatherResponse.swift
//  NetworkAPI
//
//  Created by cagla copuroglu on 7.09.2022.
//

import Foundation

public struct DailyForecastWeatherResponse: Codable {
    public let city: City?
    let cod: String?
    let message: Double?
    let cnt: Int?
    public let list: [List]?
}
