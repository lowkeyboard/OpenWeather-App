//
//  HomeBuilder.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import UIKit

final class HomeBuilder {
    static func make() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        return viewController
    }
}
