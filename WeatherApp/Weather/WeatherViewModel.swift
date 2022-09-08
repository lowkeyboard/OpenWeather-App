//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

final class WeatherViewModel: WeatherViewModelProtocol {
    
    weak var delegate: WeatherViewModelDelegate?
    private let presentation: WeatherPresentation?
    var apiKey: String?
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func load() {
        guard let presentation = presentation else {
            return
        }
        delegate?.showDetail(presentation)
    }
}
