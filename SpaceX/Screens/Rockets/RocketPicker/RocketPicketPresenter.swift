//
//  RocketPicketPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


protocol RocketPicketPresenter {
    
}


class RocketPicket {
    
    let rocketService: RocketInfoPresenterProtocol
    
    init(rocketService: RocketInfoPresenterProtocol) {
        self.rocketService = rocketService
    }
    
}
