//
//  Alert.swift
//  WeatherApp
//
//  Created by cagla copuroglu on 9.09.2022.
//

import UIKit

struct Alert {
    static func showActionAlert(_ title: String, message: String, actionTitle: String, vc: UIViewController,
                                actionHandler: ((UIAlertAction) -> Void)? = nil,
                                dismissHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Locarion Service off", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: dismissHandler)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
}
