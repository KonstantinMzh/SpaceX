//
//  LaunchesPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 12.11.2021.
//

import Foundation
import SpaceSDK


protocol LaunchesPresenterProtocol {
    func fetchLaunches()
    func getNumberOfElementsForSection(_ section: Int) -> Int
    func getLaunchAtIndexPath(_ indexPath: IndexPath) -> Launch?
    func getTitleForRocketWithId(_ id: String, completion: @escaping (Result<String, SpaceError>) -> Void)
}


class LaunchesPresenter: LaunchesPresenterProtocol {

    
    
    let spaceService: SpaceServiceProtocol
    weak var viewController: LaunchesViewController?
    
    var futureLaunches: [Launch] = []
    var oldLaunches: [Launch] = []
    
    
    //MARK: - Fetching
    func fetchLaunches() {
        spaceService.fetchLaunches { [weak self] result in
            switch result {
            case.failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let launches):
                self?.futureLaunches = launches
                    .filter { $0.date > Date().timeIntervalSince1970 }
                    .sorted { $0.date < $1.date }
                
                self?.oldLaunches = launches
                    .filter { $0.date < Date()
                    .timeIntervalSince1970 }.sorted { $0.date < $1.date }
                self?.viewController?.updateUI()
            }
        }
    }
    
    func getTitleForRocketWithId(_ id: String, completion: @escaping (Result<String, SpaceError>) -> Void) {
        spaceService.fetchRocketById(id) { result in
            switch result {
            case .success(let rocket):
                completion(.success(rocket.name))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfElementsForSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return futureLaunches.count
        case 1:
            return oldLaunches.count
        default:
            return 0
        }
    }
    
    func getLaunchAtIndexPath(_ indexPath: IndexPath) -> Launch? {
        switch indexPath.section {
        case 0:
            return futureLaunches[indexPath.row]
        case 1:
            return oldLaunches[indexPath.row]
        default:
            return nil
        }
    }
    
    
    //MARK: - Init
    init(viewController: LaunchesViewController,
         rocketService: SpaceServiceProtocol) {
        self.viewController = viewController
        self.spaceService = rocketService
    }
    
}
