//
//  RocketInfoPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


protocol RocketInfoPresenterProtocol: PickerDelegate {
    func getRocketByIndex(_ index: Int)
    func getRocketsTitles() -> [String]
}


class RocketInfoPresenter: RocketInfoPresenterProtocol {
    
    //MARK: - Properties
    let spaceService: SpaceServiceProtocol
    weak var viewController: RocketInfoViewController?
     
    func getRocketByIndex(_ index: Int) {
        spaceService.getRocketByIndex(index) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let rocket):
                self?.viewController?.updateUIForRocket(rocket)
            }
        }
    }
    
    func getRocketsTitles() -> [String] {
        return spaceService.getRocketsTitles()
    }
    
    
    //MARK: - Init
    init(viewController: RocketInfoViewController,
         rocketService: SpaceServiceProtocol) {
        self.viewController = viewController
        self.spaceService = rocketService
    }
    
}


//MARK: - Picker Delegate
extension RocketInfoPresenter {
    func didSelectAtIndex(_ index: Int) {
        getRocketByIndex(index)
    }
}
