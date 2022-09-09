//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 8.09.2022.
//

import Foundation
import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel(service: appContainer.service)
    private let notificationCenter = NotificationCenter.default
    private var observer: NSObjectProtocol?
    @IBOutlet weak var keyText: UITextField!
    
    var alertView: UIAlertController {
        let alert = UIAlertController(title: "Locarion Service off", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        let action = UIAlertAction(title: "Turn on in Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        return alert
    }
    
    
    
    override func viewDidLoad() {
        viewModel.delegate = self
        LocationManager.shared.checkLocationService()
        observerNotification()
//        keyText.text = "8ddadecc7ae4f56fee73b2b405a63659"
        observer = notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main, using: { notification in
            print("willEnterForegroundNotification")
        })
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func keyTextField(_ sender: Any) {
        
    }
    
    @IBAction func loginButton(_ sender: Any) {

        if (KeyManager.shared.isOpenedFromUrl) {
            viewModel.keyObtained(apiKey: KeyManager.shared.apiKey )
        } else {
            guard let keyTF = keyText.text, !keyTF.isEmpty else {
                print("empty input handling")
                let alert = UIAlertController(title: "Cannot be left empty.", message: "Please enter your apikey.", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"Request Failed\" alert occured.")
                }))
                    self.present(alert, animated: true, completion: nil)
                return
            }

            viewModel.keyObtained(apiKey: keyTF)

        }

        print("button pressed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("--- viewWillDisappear ---")
        notificationCenter.removeObserver(self)
        
        if let observer = observer {
            notificationCenter.removeObserver(observer)
        }
    }
    
    func observerNotification() {
        notificationCenter.addObserver(forName: .sharedLocation, object: nil, queue: .main) { notification in
            
            guard let object = notification.object as? [String: Any] else { return }
            guard let error = object["error"] as? Bool else { return }
            
            if error {
                print("error to access location service.")
                
                
            } else {
                guard let location = object["location"] as? CLLocation else { return }
                print(location.coordinate.latitude)
            }
            
            
        }
    }
}



extension HomeViewController: HomeViewModelDelegate {
    
    func navigate(to route: HomeViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = WeatherBuilder.make(with: viewModel, key: self.keyText.text ?? KeyManager.shared.apiKey)
//            viewController.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(viewController, animated: false)
//            showDetailViewController(viewController, sender: nil)
            // show(viewController, animated: false)
        }
    }
    
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.keyText.text = title
        }
    }
}
