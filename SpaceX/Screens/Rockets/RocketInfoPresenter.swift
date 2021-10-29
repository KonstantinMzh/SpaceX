//
//  RocketInfoPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation
import SpaceSDK


protocol RocketInfoPresenterProtocol: PickerDelegate {
    func getRocketByIndex(_ index: Int)
    func fetchRockets()
}


class RocketInfoPresenter: RocketInfoPresenterProtocol {
    
    
    //MARK: - Properties
    private var rockets: [Rocket] = [] {
        didSet {
            let titles = rockets.map { $0.name }
            viewController?.updatePicker(rocketTitles: titles)
        }
    }
    
    let spaceService: SpaceServiceProtocol
    weak var viewController: RocketInfoViewController?
     
    func getRocketByIndex(_ index: Int) {
        
        if let rocket = rockets[safe: index] {
            viewController?.updateUIForRocket(rocket)
        } else {
            viewController?.showSimpleAlert(withTitle: "Ошибка", message: "Не удалось загрузить данные для ракеты")
        }

    }
    
    func fetchRockets() {
        spaceService.fetchRockets { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Ошибка", message: error.localizedDescription)
            case .success(let rockets):
                self?.rockets = rockets
            }
        }
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
