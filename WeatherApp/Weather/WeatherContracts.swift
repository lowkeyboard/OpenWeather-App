//
//  WeatherContracts.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import UIKit
import NetworkAPI

protocol WeatherViewModelProtocol: AnyObject {
    var delegate: WeatherViewModelDelegate? { get set }
    func loadCurrentForecast()
    func loadDailyForecast()
    func showIconView(iconName: String, iconView: UIImageView)
}

enum WeatherViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showCurrent(CurrentWeatherPresentation)
    case showDaily([List])
}

protocol WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput)
}
