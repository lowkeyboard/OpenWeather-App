//
//  Service.swift
//  NetworkAPI
//
//  Created by cagla copuroglu on 7.09.2022.
//

import Foundation

//example url: https://api.openweathermap.org/data/2.5/weather?lat=51.50998&lon=-0.1337&appid=YOUR_API_KEY&units=metric
//https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&cnt=7&appid=8ddadecc7ae4f56fee73b2b405a63659
//iconurl: "http://openweathermap.org/img/wn/10d@2x.png"
enum Service {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "8ddadecc7ae4f56fee73b2b405a63659"
    static let iconUrl = "http://openweathermap.org/img/wn/"
}
