//
//  EquipmentsPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 14.11.2021.
//

import Foundation


protocol EquipmentsPresenterProtocol {
    func getNumberOfEquipments() -> Int
    func getEquipmentAtRow(_ row: Int) -> Equipment?
    
    func pushRocketsScreen()
}


class EquipmentsPresenter: EquipmentsPresenterProtocol {
    
    let factory: ScreenFactory
    
    var equipments: [EquipmentsType] = [.rocket, .capsule]
    
    weak var viewController: EquipmentsViewController?
    
    func getNumberOfEquipments() -> Int {
        return equipments.count
    }
    
    func getEquipmentAtRow(_ row: Int) -> Equipment? {
        guard let equipment = equipments[safe: row] else { return nil }
        return equipment.getEquipment()
    }
    
    init(viewController: EquipmentsViewController, factory: ScreenFactory) {
        self.viewController = viewController
        self.factory = factory
    }
    
    
    //MARK: - Navigation
    func pushRocketsScreen() {
        let rocketsViewController = factory.createEquipmentDetailScreen()
        viewController?.navigationController?.pushViewController(rocketsViewController, animated: true)
    }
    
}
