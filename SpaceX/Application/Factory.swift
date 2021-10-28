//
//  Factory.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation
import SpaceSDK


final class ScreenFactory {
    
    fileprivate let applicationFactory = ApplicationFactory()
        
    func createRocketsScreen() -> PickerViewController {
        let pickerViewController = PickerViewController()
        let rocketViewController = RocketInfoViewController()
        let rocketPresenter: RocketInfoPresenterProtocol = RocketInfoPresenter(viewController: rocketViewController,
                                                                               rocketService: applicationFactory.spaceService)
        rocketViewController.presenter = rocketPresenter
        pickerViewController.addContentController(rocketViewController)
        rocketViewController.picker = pickerViewController
        pickerViewController.delegate = rocketPresenter
        return pickerViewController
    }
    
}


fileprivate final class ApplicationFactory {
    
    fileprivate let spaceService: SpaceServiceProtocol
    
    fileprivate init() {
        spaceService = SpaceService()
    }
    
}

