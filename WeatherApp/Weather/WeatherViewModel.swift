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
    
    var delegate: WeatherViewModelDelegate?
    private var currentResult: CurrentForecastWeatherResponse?
    private var presentationCurrent: CurrentWeatherPresentation?
    private let service: ServiceProtocol
    private var dailyList: [List] = []
    private var present =  DailyWeatherRepresentation(cnt: 0, dateTime: "", temperature: nil, iconName: "")
    private var dailyArray : [DailyWeatherRepresentation] = []
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func formatEpochToDay(epochTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: epochTime)
        print(date)  //2022-09-09 12:55:22.790803+0300
        
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd MMMM"

        var dateTimeString = "\(date)"
        
        dateTimeString = "\(dateTimeString.split(separator: " ").first ?? "nil")"
        
          return dateTimeString

    }
    

    
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
    
    func loadCurrentForecast() {
        notify(.updateTitle("Weathers"))
        notify(.setLoading(true))
        
        guard let lat = LocationManager.shared.lat else { return }
        guard let lon = LocationManager.shared.lon else { return }
        let apiKey = KeyManager.shared.apiKey

        notify(.updateLocationTitle("CityName"))
        
        
        service.requestCurrentForecastWeather(lat: lat, lon: lon, key: apiKey, success: { [weak self] model in
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
        guard let lat = LocationManager.shared.lat else { return }
        guard let lon = LocationManager.shared.lon else { return }
        let apiKey = KeyManager.shared.apiKey

        DispatchQueue.global(qos: .background).async {
            
            self.service.requestDailyForecastWeather(lat: lat, lon: lon, cnt: 7, key: apiKey, success: { [weak self] model in
                guard let self = self else { return }
                self.notify(.setLoading(false))
                guard let responseList = model.list else { return }
    
                self.notify(.showDaily(responseList))
                
                
            }, failure: { error in
                print(error ?? "Error occured with Weather service.")
            })
        }
        
    }
    
    
    private func notify(_ output: WeatherViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    
}
