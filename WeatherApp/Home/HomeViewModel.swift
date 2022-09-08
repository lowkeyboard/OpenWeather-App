//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

enum HomeViewRoute {
    case detail(WeatherViewModelProtocol)
}

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
}

protocol HomeViewModelDelegate  {
    func navigate(to route: HomeViewRoute)
}

final class HomeViewModel {
    private let service: ServiceProtocol
    private var delegate: HomeViewModelDelegate
    
    init(service: ServiceProtocol) {
        self.service = service
        
    }
    
    
    func keyObtained(apiKey: String) {
        let viewModel = WeatherViewModel(apiKey: apiKey)
        delegate.navigate(to: .detail(viewModel))
    }

}
