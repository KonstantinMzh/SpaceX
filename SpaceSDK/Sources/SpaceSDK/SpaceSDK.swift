//
//  SpaceService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


public protocol SpaceServiceProtocol {
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void)
    func fetchLaunches(completion: @escaping (Result<[Launch], SpaceError>) -> Void)
    func fetchRocketById(_ id: String, completion: @escaping (Result<Rocket, SpaceError>) -> Void)
}


public class SpaceService: SpaceServiceProtocol {
    
    let networkManager: NetworkManagerProtocol

    
    public func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .rockets) { result in
            completion(result)
        }
    }
    
    public func fetchLaunches(completion: @escaping (Result<[Launch], SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .launches) { result in
            completion(result)
        }
    }
    
    public func fetchRocketById(_ id: String, completion: @escaping (Result<Rocket, SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .rocket(id)) { result in
            completion(result)
        }
    }

    
    
    public init() {
        networkManager = NetworkManager()
    }
    
}
