//
//  WeatherPresentation.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import NetworkAPI

final class CurrentWeatherPresentation: NSObject {
    var temperature: Double?
    var iconName: String
    
    init(temperature: Double?, iconName: String) {
        self.temperature = temperature
        self.iconName = iconName
    }
    
}

extension CurrentWeatherPresentation {
    convenience init(current: Weather, temp: Temp) {
        self.init(temperature: temp.max, iconName: current.icon ?? "")
    }
}
