//
//  DailyWeatherPresentation.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

final class DailyWeatherRepresentation: NSObject {
    var cnt: Int?
    var dateTime: String
    var temperature: Double?
    var iconName: String
    
    
    init(cnt: Int?, dateTime: String, temperature: Double?, iconName: String) {
        self.cnt = cnt
        self.dateTime = dateTime
        self.temperature = temperature
        self.iconName = iconName
    }
    
}

//
//extension DailyWeatherRepresentation {
//    convenience init(list: List) {
////        self.init(list: list.dt , list.temp, list.weather.first?.icon)
//          self.init()
//
//    }
//}
