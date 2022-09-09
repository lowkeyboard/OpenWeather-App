//
//  DailyWeatherPresentation.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

final class DailyWeatherRepresentation: NSObject {
    var dateTime: String
    var temperature: Double?
    var iconName: String
    
    
    init(dateTime: String, temperature: Double?, iconName: String) {
        self.dateTime = dateTime
        self.temperature = temperature
        self.iconName = iconName
    }
    
}

//extension DailyWeatherRepresentation {
//    convenience init(dateTime: String) {
////        self.init(list: list.dt , list.temp, list.weather.first?.icon)
//          self.init(da , list.temp, list.weather.first?.icon)
//
//    }
//}
