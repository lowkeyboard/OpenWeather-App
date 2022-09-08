//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import NetworkAPI

final class HomeViewModel {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }

}
