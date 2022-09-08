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

    func load() {

        notify(.updateTitle("Weathers"))
        notify(.setLoading(true))

        service.requestCurrentForecastWeather(lat: 10, lon: 20, success: { [weak self] model in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            self.currentResult = model
            self.presentationCurrent?.temperature = self.currentResult?.main?.tempMax
            self.presentationCurrent?.iconName = (self.currentResult?.weather?.first?.icon)!
            self.notify(.showCurrent(self.presentationCurrent!))
        }, failure: { error in
            print(error ?? "Error occured with Weather service.")
        })

    }

    func selectWeather(at index: Int) {
        print("Weather at \(index) has selected")
        self.coordinator?.navigateToDetail(index: index)

    }

    private func notify(_ output: WeatherViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }


}
