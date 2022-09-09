//
//  WeatherBuilder.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import UIKit

final class WeatherBuilder {
    
    static func make(with viewModel: WeatherViewModelProtocol, key: String) -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Weather", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        
        viewController.viewModel = viewModel
        KeyManager.shared.apiKey = key
        return viewController
    }
}
