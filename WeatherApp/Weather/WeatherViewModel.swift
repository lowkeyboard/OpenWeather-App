//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

final class WeatherViewModel: WeatherViewModelProtocol {
    var delegate: WeatherViewModelDelegate?
    var key: String
    private var currentResult: CurrentForecastWeatherResponse?
    private var presentationCurrent: CurrentWeatherPresentation?
    private let service: ServiceProtocol

    init(service: ServiceProtocol, key: String) {
        self.service = service
        self.key = key
    }

    func loadCurrentForecast() {
        notify(.updateTitle("Weathers"))
        notify(.setLoading(true))

        service.requestCurrentForecastWeather(lat: 10, lon: 20, success: { [weak self] model in
            guard let self = self else { return }
            self.notify(.setLoading(false))
        
            let present: CurrentWeatherPresentation = CurrentWeatherPresentation(temperature: model.main?.temp, iconName: model.weather?.first?.icon ?? "")

            self.notify(.showCurrent(present))

        }, failure: { error in
            print(error ?? "Error occured with Weather service.")
        })
    }
    
    func loadDailyForecast() {
        notify(.updateTitle("Daily Weather"))
        notify(.setLoading(true))

        service.requestDailyForecastWeather(lat: 44.34, lon: 10.99, cnt: 7) { [weak self] model in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            guard let response = model.list else { return }
            let present: DailyWeatherRepresentation  = DailyWeatherRepresentation(list: response)
    
            self.notify(.showDaily([present]))
            
        } failure: { error in
            print(error ?? "Error occured with Weather service.")
        }



    }


    private func notify(_ output: WeatherViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }


}
