//
//  RocketService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 02.12.2021.
//

import Foundation
import SpaceSDK


protocol RocketServiceProtocol {
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void)
    func fetchCompanyInfo(completion: @escaping (Result<Company, SpaceError>) -> Void)
}

class RocketService: RocketServiceProtocol {
    
    let spaceService: SpaceServiceProtocol
    let coreDataService: CoreDataServiceProtocol
    
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void) {
        spaceService.fetchRockets { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let rockets):
                break
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
    
    init(spaceService: SpaceServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        self.spaceService = spaceService
        self.coreDataService = coreDataService
    }
    
}
