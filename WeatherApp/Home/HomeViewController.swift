//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    

    @IBAction func keyTextField(_ sender: Any) {
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        viewModel.keyObtained(apiKey: <#T##String#>)
    }
    
    override func viewDidLoad() {
        
    }
    
    
}

extension HomeViewController: HomeViewModelDelegate {
        
    func navigate(to route: HomeViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = WeatherBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}
