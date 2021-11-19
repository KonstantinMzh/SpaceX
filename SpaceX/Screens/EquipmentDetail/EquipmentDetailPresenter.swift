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
    
    private var equipments: [Rocket] = [] {
        didSet {
            let titles = equipments.map { $0.name }
            viewController?.updatePicker(titles)
        }
    }

    func fetchRockets() {
        spaceService.fetchRockets { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let rockets):
                self?.equipments = rockets
            }
        }
    }
    
    private func getEquipmentByIndex(_ index: Int) {
        
        if let rocket = equipments[safe: index] {
            viewController?.updateUIForEntity(rocket)
        } else {
            viewController?.showSimpleAlert(withTitle: "Ошибка", message: "Не удалось загрузить данные")
        }

    }


    init(viewController: EquipmentDetailViewController,
         rocketService: SpaceServiceProtocol) {
        self.viewController = viewController
        self.spaceService = rocketService
    }
    
}


//MARK: - Picker Delegate
extension EquipmentDetailPresenter: PickerDelegate {
    func didSelectAtIndex(_ index: Int) {
        getEquipmentByIndex(index)
    }
}
