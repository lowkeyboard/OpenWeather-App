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

    public func requestCurrentForecastWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, key: String, success: @escaping (CurrentForecastWeatherResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = "\(Service.baseUrl)weather?lat=\(lat)&lon=\(lon)&appid=\(key)&units=metric"
        let params: [String:String] = [
            "lat": "\"(lat)",
            "lon": "\(lon)",
            "appid": key,
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
    
    public func requestDailyForecastWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, cnt: Int, key: String, success: @escaping (DailyForecastWeatherResponse) -> Void, failure: @escaping (Error?) -> Void) {
        
        //https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&cnt=7&appid=8ddadecc7ae4f56fee73b2b405a63659
        
//        let url = "\(Service.baseUrl)forecast?lat=\(lat)&lon=\(lon)&con=\(cnt)&appid=\(Service.apiKey)"
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&cnt=7&appid=\(key)"
        let params: [String:String] = [
            "lat": "\(lat)",
            "lon": "\(lon)",
            "appid": key,
          ]
        
            print("Sending request... \(url)")
        
    
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).validate().responseDecodable(of: DailyForecastWeatherResponse.self) {  (model) in
            guard let data = model.value else {
                return
            }
            success(data)
        }
        
    }
    
    
}
