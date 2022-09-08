//
//  WeatherContracts.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation

protocol WeatherViewModelProtocol: AnyObject {
    var delegate: WeatherViewModelDelegate? { get set }
    func load()

}

enum WeatherViewModelOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showCurrent(CurrentWeatherPresentation)
    case showDaily(DailyWeatherRepresentation) //equatable arr
}

protocol WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput)
}
