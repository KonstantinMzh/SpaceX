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
        let equipmentViewController = createEquipmentScreen()
        
        let launchesViewController = createLaunchesScreen()
        
        let companyInfoViewController = createCompanyInfoScreen()
        

        tabBarController.viewControllers = [equipmentViewController, launchesViewController, companyInfoViewController]
        
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
    
    func createCompanyInfoScreen() -> CompanyInfoViewController {
        let viewController = CompanyInfoViewController()
        let presenter: CompanyInfoPresenterProtocol = CompanyInfoPresenter(service:
                                                                            applicationFactory.spaceService,
                                                                           viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }

    func createLaunchesScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        let viewController = LaunchesViewController()
        let launchesPresenter: LaunchesPresenterProtocol = LaunchesPresenter(viewController: viewController,
                                                                             rocketService: applicationFactory.spaceService,
                                                                             factory: self)
        viewController.presenter = launchesPresenter
        navigationController.pushViewController(viewController, animated: false)
        return navigationController
    }
    
    func createLaunchDetailScreenForId(_ id: String, title: String) -> LaunchDetailViewController {
        let viewController = LaunchDetailViewController(title: title)
        let presenter: LaunchDetailPresenterProtocol = LaunchDetailPresenter(id: id,
                                                                             spaceService: applicationFactory.spaceService,
                                                                             viewController: viewController,
                                                                             factory: self)
        viewController.presenter = presenter
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
    
    func createScreenForAppearingRocket(rocket: Rocket) -> EquipmentDetailViewController {
        let viewControler = EquipmentDetailViewController(rocket: rocket)
        let presenter = EquipmentDetailPresenter(equipmentType: .rocket,
                                                 viewController: viewControler,
                                                 rocketService: applicationFactory.spaceService)
        viewControler.presenter = presenter
        return viewControler
    }
    
    
    
}


fileprivate final class ApplicationFactory {
    
    fileprivate let spaceService: SpaceServiceProtocol
    
    fileprivate init() {
        spaceService = SpaceService()
    }
    
}

