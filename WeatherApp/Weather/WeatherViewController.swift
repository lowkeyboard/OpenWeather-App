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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.load()
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func handleViewModelOutput(_ output: WeatherViewModelOutput) {
        
    }
    
    
}
