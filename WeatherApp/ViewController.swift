//
//  ViewController.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 7.09.2022.
//

import UIKit
import NetworkAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let service = NetworkService()
        
        service.requestDailyForecastWeather(lat: 51.50998, lon: 0.1337) { response in
            print(response)
        } failure: { err in
            print(err)
        }

    }
    


}

