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
            self.weatherTitle.text = "\(self.currentWeather?.temperature)"
            guard let icon = self.currentWeather?.iconName else { return }
            viewModel.showIconView(iconName: icon, iconView: self.iconView)
  

            
        case .showDaily(let present):
            print("showDaily...")
            self.presentDaily.append(present)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentDaily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //      let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let pre = self.presentDaily[indexPath.row].temperature
        cell.dayLabel.text = "\(String(describing: pre))"
        
        print(cell.dayLabel.text)
        
        cell.backgroundColor = .green
        
        return cell
        
    }
    
    
}
