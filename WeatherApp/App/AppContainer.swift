//
//  AppContainer.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import NetworkAPI

let appContainer = AppContainer()

final class AppContainer {
    
    let router = AppRouter()
    let service = NetworkService()
}
