//
//  NetworkService.swift
//  NetworkAPI
//
//  Created by cagla copuroglu on 7.09.2022.
//

import Foundation
import Alamofire
import CoreLocation

public class NetworkService: ServiceProtocol {
    
    public init() {}

    public func requestCurrentForecastWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, success: @escaping (CurrentForecastWeatherResponse) -> Void, failure: @escaping (Error?) -> Void) {
        let url = "\(Service.baseUrl)/weather?lat=\(lat)&lon=\(lon)&appid=8ddadecc7ae4f56fee73b2b405a63659&units=metric"
        
        let params: [String:String] = [
            "lat": "\"(lat)",
            "lon": "\(lon)",
            "appid": Service.apiKey,
            "units":"metric"]
        
            print("Sending request... \(url)")
        
        AF.request(url, method: .get, parameters: params).validate().responseDecodable(of: CurrentForecastWeatherResponse.self) { (model) in
            guard let data = model.value else {
                print(model.response ?? "")
                return
            }
            success(data)
        }
        
    }
    
    public func requestDailyForecastWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, cnt: Int, success: @escaping (DailyForecastWeatherResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
        
        
    }
    
    
}
