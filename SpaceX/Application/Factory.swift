//
//  Factory.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation
import SpaceSDK
import UIKit


final class ScreenFactory {
    
    fileprivate let applicationFactory = ApplicationFactory()
    
    func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        let rocketsViewController = createRocketsScreen()
        
        let dummyViewController2 = UIViewController()
        dummyViewController2.view.backgroundColor = .systemBlue
        
        let dummyViewController3 = UIViewController()
        dummyViewController3.view.backgroundColor = .systemYellow
        

        tabBarController.viewControllers = [rocketsViewController, dummyViewController2, dummyViewController3]
        
        let item1 = tabBarController.tabBar.items?[safe: 0]
        item1?.image = UIImage(named: "rocket")
        item1?.title = "Ракеты"
        
        let item2 = tabBarController.tabBar.items?[safe: 1]
        item2?.image = UIImage(named: "launch")
        item2?.title = "Запуски"
        
        let item3 = tabBarController.tabBar.items?[safe: 2]
        item3?.image = UIImage(named: "detail")
        item3?.title = "О SpaceX"
        
        tabBarController.tabBar.tintColor = .systemOrange
        
        return tabBarController
    }
        
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

