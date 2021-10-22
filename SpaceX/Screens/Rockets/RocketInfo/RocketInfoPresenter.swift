//
//  RocketInfoPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


protocol RocketInfoPresenterProtocol {
    
}


class RocketInfoPresenter: RocketInfoPresenterProtocol {
    
    let rocketService: RocketInfoPresenterProtocol
    
    init(rocketService: RocketInfoPresenterProtocol) {
        self.rocketService = rocketService
    }
    
}
