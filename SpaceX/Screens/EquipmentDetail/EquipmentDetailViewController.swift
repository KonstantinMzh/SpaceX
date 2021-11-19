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
        
        let stageView = StageSelector(options: ["Option 1", "Option 2"])
        stageView.translatesAutoresizingMaskIntoConstraints = false
        stageView.delegate = self
        view.addSubview(stageView)
        
        NSLayoutConstraint.activate([
            stageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}


extension EquipmentDetailViewController: StageSelectorDelegate {
    
    func optionDidChoosed(_ option: Int) {
        print(option)
    }
}
