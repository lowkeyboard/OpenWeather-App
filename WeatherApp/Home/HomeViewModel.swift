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

protocol HomeViewModelProtocol: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    func keyObtained(apiKey: String)
}

protocol HomeViewModelDelegate: AnyObject  {
    func navigate(to route: HomeViewRoute)
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private let service: ServiceProtocol
    weak var delegate: HomeViewModelDelegate?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    
    func keyObtained(apiKey: String) {
        let viewModel = WeatherViewModel(apiKey: apiKey)
        delegate?.navigate(to: .detail(viewModel))
    }

}
