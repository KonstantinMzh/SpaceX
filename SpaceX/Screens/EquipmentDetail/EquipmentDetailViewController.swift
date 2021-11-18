//
//  EquipmentDetailViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import UIKit


class EquipmentDetailViewController: UIViewController {
    
    var presenter: EquipmentDetailPresenterProtocol?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = Colors.background
        
        let valueView = StageRowWithTwoValues(key: "Thrust", firstMeasurementUnit: .kN, secondMeasurementUnit: .lbf)
        valueView.translatesAutoresizingMaskIntoConstraints = false
        valueView.setValues(first: "420", second: "94000")
        
        
        view.addSubview(valueView)
        
        NSLayoutConstraint.activate([
            valueView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueView.widthAnchor.constraint(equalToConstant: 300),
            valueView.heightAnchor.constraint(equalToConstant: 50)
        ])

    
    }
    
}




