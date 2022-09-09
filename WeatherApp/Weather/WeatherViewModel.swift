//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI
import UIKit

final class WeatherViewModel: WeatherViewModelProtocol {
    func showIconView(iconName: String, iconView: UIImageView) {
        if let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    iconView.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
    
    var delegate: WeatherViewModelDelegate?
    var key: String
    private var currentResult: CurrentForecastWeatherResponse?
    private var presentationCurrent: CurrentWeatherPresentation?
    private let service: ServiceProtocol
    private var dailyList: [List] = []
    private var present =  DailyWeatherRepresentation(cnt: 0, dateTime: "", temperature: nil, iconName: "")

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
        DispatchQueue.global(qos: .background).async {
            
            self.service.requestDailyForecastWeather(lat: 44.34, lon: 10.99, cnt: 7, success: { [weak self] model in
                guard let self = self else { return }
                self.notify(.setLoading(false))
                guard let response = model.list else { return }
                
                self.dailyList = response
                _ = self.dailyList.map { element in
                    self.present.cnt = self.dailyList.count
                    self.present.dateTime = "\(element.dt)"
                    self.present.temperature = element.temp?.day
                    self.present.iconName = element.weather?.first?.icon ?? "04n"
                }
                
                self.notify(.showDaily(self.present))
                
                
            }, failure: { error in
                print(error ?? "Error occured with Weather service.")
            })
        }
        
    }
    
    
    private func notify(_ output: WeatherViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    
}
