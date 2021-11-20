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
        let rocketsViewController = createEquipmentScreen()
        
        let dummyViewController2 = createLaunchesScreen()
        
        let dummyViewController3 = UIViewController()
        dummyViewController3.view.backgroundColor = .systemYellow
        

        tabBarController.viewControllers = [rocketsViewController, dummyViewController2, dummyViewController3]
        
        let item1 = tabBarController.tabBar.items?[safe: 0]
        item1?.image = UIImage(named: "rocket")
        item1?.title = "Rockets"
        
        let item2 = tabBarController.tabBar.items?[safe: 1]
        item2?.image = UIImage(named: "launch")
        item2?.title = "Launches"
        
        let item3 = tabBarController.tabBar.items?[safe: 2]
        item3?.image = UIImage(named: "detail")
        item3?.title = "SpaceX"
        
        tabBarController.tabBar.tintColor = Colors.mainAccent
        
        return tabBarController
    }
        
    func createEquipmentScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        let viewController = EquipmentsViewController()
        let presenter: EquipmentsPresenterProtocol = EquipmentsPresenter(viewController: viewController,
                                                                         factory: self)
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: false)
        return navigationController
    }

    func createLaunchesScreen() -> LaunchesViewController {
        let viewController = LaunchesViewController()
        let launchesPresenter: LaunchesPresenterProtocol = LaunchesPresenter(viewController: viewController,
                                                                             rocketService: applicationFactory.spaceService)
        viewController.presenter = launchesPresenter
        return viewController
    }
    
    func createEquipmentDetailScreen(equipmentType: EquipmentsType) -> PickerViewController {
        let pickerViewController = PickerViewController()
        let equipmentViewController = EquipmentDetailViewController()

        let presenter = EquipmentDetailPresenter(equipmentType: equipmentType,
                                                 viewController: equipmentViewController,
                                                 rocketService: applicationFactory.spaceService)

        equipmentViewController.presenter = presenter
        pickerViewController.addContentController(equipmentViewController)
        equipmentViewController.picker = pickerViewController
        pickerViewController.delegate = presenter
        
        
        return pickerViewController
    }
    
}


fileprivate final class ApplicationFactory {
    
    fileprivate let spaceService: SpaceServiceProtocol
    
    fileprivate init() {
        spaceService = SpaceService()
    }
    
}

