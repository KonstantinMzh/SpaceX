//
//  UIViewController+Extension.swift
//  SpaceX
//
//  Created by Константин Маламуж on 29.10.2021.
//

import UIKit


extension UIViewController {
    
    func showSimpleAlert(withTitle title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension UIViewController {
    
    func configureNavigationBar(title: String, preferredLargeTitle: Bool) {
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        
        } else {
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
        
    }
    
}
