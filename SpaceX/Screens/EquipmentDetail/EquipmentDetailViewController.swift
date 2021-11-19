//
//  EquipmentDetailViewController.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import UIKit
import SpaceSDK

class EquipmentDetailViewController: UIViewController {
    
    var presenter: EquipmentDetailPresenterProtocol?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.fetchRockets()
    }
    
    func configure() {
        view.backgroundColor = Colors.background
        
        
        
    }
        
    func addStage(_ stage: Stage) {
        let stageView = StageView()
        stageView.prepareForStage(stage)
        stageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stageView)
        
        NSLayoutConstraint.activate([
            stageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stageView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
}


extension EquipmentDetailViewController: StageSelectorDelegate {
    
    func optionDidSelected(_ option: Int) {
        print(option)
    }
}
