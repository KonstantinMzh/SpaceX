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
}

class LaunchDetailPresenter: LaunchDetailPresenterProtocol {
    
    //MARK: - Properties
    private let spaceService: SpaceServiceProtocol
    private weak var viewController: LaunchDetailViewController?
    private let id: String
    
    
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
    
    
    //MARK: - Init
    init(id: String, spaceService: SpaceServiceProtocol, viewController: LaunchDetailViewController) {
        self.id = id
        self.spaceService = spaceService
        self.viewController = viewController
    }
    
}
