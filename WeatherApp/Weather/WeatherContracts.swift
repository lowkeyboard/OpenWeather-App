//
//  WeatherContracts.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation

protocol WeatherViewModelProtocol: AnyObject {
    var delegate: WeatherViewModelDelegate? { get set }
    func loadCurrentForecast()
    func loadDailyForecast()


}

enum WeatherViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showCurrent(CurrentWeatherPresentation)
    case showDaily(DailyWeatherRepresentation)
}

protocol WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput)
}
