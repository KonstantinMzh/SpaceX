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
        
        let stageView = StageGallery()
        stageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stageView)
        

        NSLayoutConstraint.activate([
            stageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
        
    func addStage(_ stages: [Stage]) {
        let stageView = StageGallery()
        stageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stageView)
        stageView.stages = stages

        NSLayoutConstraint.activate([
            stageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}


extension EquipmentDetailViewController: StageSelectorDelegate {
    
    func optionDidSelected(_ option: Int) {
        print(option)
    }
}
