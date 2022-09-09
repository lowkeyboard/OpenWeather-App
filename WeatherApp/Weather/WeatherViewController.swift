//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import UIKit
import NetworkAPI

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherViewModelProtocol!
    private var currentWeather: CurrentWeatherPresentation?
    var presentDaily : [DailyWeatherRepresentation] = []
    var presentList: [List] = []
    var key: String?
    
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadCurrentForecast()
        viewModel.loadDailyForecast()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.title = "Weather App"
        
        
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.weatherTitle.text = title
        case .updateLocationTitle(let title):
            self.locationTitle.text = title
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showCurrent(let currentWeather):
            self.currentWeather = currentWeather
            guard let temp = self.currentWeather?.temperature else { return }
            guard let icon = self.currentWeather?.iconName else { return }
            self.weatherTitle.text = "\(temp)°"
            viewModel.showIconView(iconName: icon, iconView: self.iconView)
  

            
        case .showDaily(let present):
            print("showDaily...")
            self.presentList = present
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        guard let pre = self.presentList[indexPath.row].dt else { return UITableViewCell() }
        guard let icon = self.presentList[indexPath.row].weather?.first?.icon else { return UITableViewCell()  }
        guard let tempHighLabel = self.presentList[indexPath.row].main?.temp_min else { return UITableViewCell()  }
        guard let tempLowLabel = self.presentList[indexPath.row].main?.temp_max else { return UITableViewCell()  }
        
        let preFormatted = viewModel.formatEpochToDay(epochTime: Double(pre))
        viewModel.showIconView(iconName: icon, iconView: cell.iconView)
        cell.dayLabel.text = "\(preFormatted)"
        cell.tempHighLabel.text = "\(tempHighLabel)°"
        cell.tempLowLabel.text = "\(tempLowLabel)°"

        
        return cell
        
    }
    
    
}
