//
//  LaunchDetailPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.11.2021.
//

import Foundation
import SpaceSDK


protocol LaunchDetailPresenterProtocol {
    func fetchLaunch()
    func getTitleForRocketWithId(_ id: String, completion: @escaping (Result<String, SpaceError>) -> Void)
    func showRocketScreen()

}

class LaunchDetailPresenter: LaunchDetailPresenterProtocol {
    
    //MARK: - Properties
    private let factory: ScreenFactory
    private let spaceService: SpaceServiceProtocol
    private weak var viewController: LaunchDetailViewController?
    private let id: String
    
    var rocket: Rocket?
    
    
    func fetchLaunch() {
        spaceService.fetchLaunchById(id) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Error", message: error.localizedDescription)
                
            case .success(let launch):
                self?.viewController?.updateUIForLaunch(launch)
            }
        }
    }
    
    func getTitleForRocketWithId(_ id: String, completion: @escaping (Result<String, SpaceError>) -> Void) {
        spaceService.fetchRocketById(id) { [weak self] result in
            switch result {
            case .success(let rocket):
                self?.rocket = rocket
                completion(.success(rocket.name))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func showRocketScreen() {
        guard let rocket = rocket else { return }
        let rocketViewController = factory.showRocketScreen(rocket: rocket)
        viewController?.present(rocketViewController, animated: true, completion: nil)
    }
    
    
    //MARK: - Init
    init(id: String,
         spaceService: SpaceServiceProtocol,
         viewController: LaunchDetailViewController, factory: ScreenFactory) {
        self.id = id
        self.spaceService = spaceService
        self.viewController = viewController
        self.factory = factory
    }
    
}
