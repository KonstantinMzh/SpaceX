//
//  EquipmentDetailPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 17.11.2021.
//

import Foundation


protocol EquipmentDetailPresenterProtocol {
    
}


class EquipmentDetailPresenter: EquipmentDetailPresenterProtocol {
    
    weak var viewController: EquipmentDetailViewController?
    
    
    init(viewController: EquipmentDetailViewController) {
        self.viewController = viewController
    }
    
}
