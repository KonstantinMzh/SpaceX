//
//  EquipmentDetailPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import Foundation
import SpaceSDK

protocol EquipmentDetailPresenterProtocol {
    func fetch()
    func getTitle() -> String
    func getType() -> EquipmentsType
}


class EquipmentDetailPresenter: EquipmentDetailPresenterProtocol {
    
    let equipmentType: EquipmentsType
    weak var viewController: EquipmentDetailViewController?
    let spaceService: RocketServiceProtocol
    
    private var rockets: [Rocket] = [] {
        didSet {
            let titles = rockets.map { $0.name }
            viewController?.updatePicker(titles)
        }
    }
    
    private var dragons: [Dragon] = [] {
        didSet {
            let titles = dragons.map { $0.name }
            viewController?.updatePicker(titles)
        }
    }

    private func fetchRockets() {
        spaceService.fetchRockets { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let rockets):
                self?.rockets = rockets
            }
        }
    }
    
    private func fetchDragons() {
        spaceService.fetchDragons { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let dragons):
                self?.dragons = dragons
            }
        }
    }
    

    func fetch() {
        switch equipmentType {
        case .rocket:
            fetchRockets()
        case .capsule:
            fetchDragons()
        }
    }
    
    func getTitle() -> String {
        return equipmentType.getEquipment().name
    }
    
    private func getRocketByIndex(_ index: Int) {
        
        if let rocket = rockets[safe: index] {
            viewController?.updateUIForRocket(rocket)
        } else {
            viewController?.showSimpleAlert(withTitle: "Ошибка", message: "Не удалось загрузить данные")
        }

    }
    
    private func getDragonByIndex(_ index: Int) {
        
        if let dragon = dragons[safe: index] {
            viewController?.updateUIForDragon(dragon)
        } else {
            viewController?.showSimpleAlert(withTitle: "Ошибка", message: "Не удалось загрузить данные")
        }

    }

    func getType() -> EquipmentsType {
        return equipmentType
    }

    init(equipmentType: EquipmentsType,
         viewController: EquipmentDetailViewController,
         rocketService: RocketServiceProtocol) {
        self.equipmentType = equipmentType
        self.viewController = viewController
        self.spaceService = rocketService
    }
    
}


//MARK: - Picker Delegate
extension EquipmentDetailPresenter: PickerDelegate {
    func didSelectAtIndex(_ index: Int) {
        switch equipmentType {
        case .rocket:
            getRocketByIndex(index)

        case .capsule:
            getDragonByIndex(index)
        }
    }
}
