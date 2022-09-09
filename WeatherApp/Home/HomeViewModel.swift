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

enum HomeViewModelOutput {
    case updateTitle(String)
}

protocol HomeViewModelDelegate: AnyObject  {
    func navigate(to route: HomeViewRoute)
    func handleViewModelOutput(_ output: HomeViewModelOutput)
}



final class HomeViewModel: HomeViewModelProtocol {
    
    private let service: ServiceProtocol
    weak var delegate: HomeViewModelDelegate?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    
    func keyObtained(apiKey: String) {
        KeyManager.shared.apiKey = apiKey
        let viewModel = WeatherViewModel(service: appContainer.service)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    func keyObtainedFromUrl() {
        let viewModel = WeatherViewModel(service: appContainer.service)
        delegate?.navigate(to: .detail(viewModel))
    }
    

    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }

    

}
