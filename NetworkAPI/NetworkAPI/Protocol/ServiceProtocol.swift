//
//  ServiceProtocol.swift
//  NetworkAPI
//
//  Created by cagla copuroglu on 7.09.2022.
//

import Foundation
import CoreLocation

public protocol ServiceProtocol {

   func requestCurrentForecastWeather( lat: CLLocationDegrees, lon: CLLocationDegrees, success: @escaping (_ model: CurrentForecastWeatherResponse) -> Void, failure: @escaping (_ error: Error?) -> Void )
    
    func requestDailyForecastWeather( lat: CLLocationDegrees, lon: CLLocationDegrees, cnt: Int, success: @escaping (_ model: DailyForecastWeatherResponse) -> Void, failure: @escaping (_ error: Error?) -> Void )

}
