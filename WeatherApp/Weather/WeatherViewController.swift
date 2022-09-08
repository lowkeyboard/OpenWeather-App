//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherViewModelProtocol!
    private var currentWeather: CurrentWeatherPresentation?
    
    @IBOutlet weak var weatherTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadCurrentForecast()
        viewModel.loadDailyForecast()
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.weatherTitle.text = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showCurrent(let currentWeather):
            self.currentWeather = currentWeather
            self.weatherTitle.text = "\(currentWeather.temperature)\n \(currentWeather.iconName)"
            self.tableView.reloadData()
        case .showDaily(let present):
            print("showDaily...")
                
            
            
        }

    }
    
    
}
