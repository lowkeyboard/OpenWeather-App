//
//  AppRouter.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let apikey = KeyManager.shared.apiKey
        let viewController = HomeBuilder.make(with: apikey)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func startFromUrl(with apiKey: String) {
        KeyManager.shared.apiKey = apiKey
        let viewController = HomeBuilder.make(with: apiKey)
        viewController.keyText.text = apiKey
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
