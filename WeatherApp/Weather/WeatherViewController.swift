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
    var presentDaily : [DailyWeatherRepresentation] = []
    
    @IBOutlet weak var weatherTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
            self.tableView.reloadData()
        case .showDaily(let present):
            print("showDaily...")
            self.presentDaily = present
            tableView.reloadData()
        }

    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentDaily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! WeatherTableViewCell
      let pre = self.presentDaily[indexPath.row]
      cell.dayLabel.text = "\(pre.dateTime)"
     
      return cell

    }
    
    
}
