//
//  RocketService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 02.12.2021.
//

import Foundation
import SpaceSDK
import UIKit
import Network


protocol RocketServiceProtocol {
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void)
    func fetchCompanyInfo(completion: @escaping (Result<Company, SpaceError>) -> Void)
    func fetchDragons(completion: @escaping (Result<[Dragon], SpaceError>) -> Void)
}

class RocketService: RocketServiceProtocol {
    
    let spaceService: SpaceServiceProtocol
    let coreDataService: CoreDataServiceProtocol
    
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void) {
        coreDataService.getRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                completion(.success(rockets))
            case .failure(_):
                self?.spaceService.fetchRockets { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let rockets):
                        self?.coreDataService.saveRockets(rockets)
                        completion(.success(rockets))
                    }
                }
            }
        }
    }
    
    
    func fetchCompanyInfo(completion: @escaping (Result<Company, SpaceError>) -> Void) {
        coreDataService.getCompanyInfo { [weak self] result in
            switch result {
            case .success(let company):
                completion(.success(company))
            case .failure(_):
                self?.spaceService.fetchCompanyInfo { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let company):
                        self?.coreDataService.saveCompanyInfo(company)
                        completion(.success(company))
                    }
                }
            }
        }
    }
    
    func fetchDragons(completion: @escaping (Result<[Dragon], SpaceError>) -> Void) {
        coreDataService.getDragons { [weak self] result in
            switch result {
            case .success(let dragons):
                completion(.success(dragons))
            case .failure(_):
                self?.spaceService.fetchDragons { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let dragons):
                        self?.coreDataService.saveDragons(dragons)
                        completion(.success(dragons))
                    }
                }
            }
        }

    }
    
    init(spaceService: SpaceServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        self.spaceService = spaceService
        self.coreDataService = coreDataService
    }
    
}
