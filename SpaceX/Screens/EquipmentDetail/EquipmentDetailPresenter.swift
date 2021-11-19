//
//  EquipmentDetailPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import Foundation
import SpaceSDK

protocol EquipmentDetailPresenterProtocol {
    func fetchRockets()
}


class EquipmentDetailPresenter: EquipmentDetailPresenterProtocol {
    
    weak var viewController: EquipmentDetailViewController?
    let spaceService: SpaceServiceProtocol

    func fetchRockets() {
        spaceService.fetchRockets { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let rockets):
                guard let stages = rockets.first?.getStages() else { return }
                self?.viewController?.addStage(stages)
            }
        }
    }


    init(viewController: EquipmentDetailViewController,
         rocketService: SpaceServiceProtocol) {
        self.viewController = viewController
        self.spaceService = rocketService
    }
    
}
