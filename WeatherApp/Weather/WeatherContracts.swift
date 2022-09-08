//
//  WeatherContracts.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation

protocol WeatherViewModelDelegate: class {
    func showDetail(_ presentation: WeatherPresentation)
}

protocol WeatherViewModelProtocol {
    var delegate: WeatherViewModelDelegate? { get set }
    func load()
}
