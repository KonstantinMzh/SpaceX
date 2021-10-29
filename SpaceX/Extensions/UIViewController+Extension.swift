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
