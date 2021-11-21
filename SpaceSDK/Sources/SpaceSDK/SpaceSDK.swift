//
//  SpaceService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


public protocol SpaceServiceProtocol {
    func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void)
    func fetchRocketById(_ id: String, completion: @escaping (Result<Rocket, SpaceError>) -> Void)
    
    func fetchLaunches(completion: @escaping (Result<[Launch], SpaceError>) -> Void)
    
    func fetchDragons(completion: @escaping (Result<[Dragon], SpaceError>) -> Void)

}


public class SpaceService: SpaceServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    var rocketCache: [String: Rocket] = [:]
    
    public func fetchRockets(completion: @escaping (Result<[Rocket], SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .rockets) { [weak self] result in
            self?.pushRocketsIntoCache(rocketResults: result, completion)
        }
    }
    
    public func fetchLaunches(completion: @escaping (Result<[Launch], SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .launches) { result in
            completion(result)
        }
    }
    
    public func fetchRocketById(_ id: String, completion: @escaping (Result<Rocket, SpaceError>) -> Void) {
        
        if let rocket = rocketCache[id] {
            completion(.success(rocket))
        } else {
            networkManager.fetch(endpoint: .rocket(id)) { [weak self] res in
                self?.pushRocketWithIdIntoCache(id, rocketResults: res, completion)
            }
        }

            
    }
        
    
    private func pushRocketWithIdIntoCache(_ id: String,
                                           rocketResults: Result<Rocket, SpaceError>,
                                           _ completion: @escaping (Result<Rocket, SpaceError>) -> Void) {
        switch rocketResults {
        case .success(let rocket):
            rocketCache[id] = rocket
        default:
            break
        }
        completion(rocketResults)
        
    }
    
    
    private func pushRocketsIntoCache(rocketResults: Result<[Rocket], SpaceError>,
                                      _ completion: @escaping (Result<[Rocket], SpaceError>) -> Void) {
        switch rocketResults {
        case .success(let rockets):
            rockets.forEach {
                rocketCache[$0.id] = $0
            }
        default:
            break
        }
        completion(rocketResults)

    }
        
    
    
    public func fetchDragons(completion: @escaping (Result<[Dragon], SpaceError>) -> Void) {
        networkManager.fetch(endpoint: .dragons) { result in
            completion(result)
        }
    }


    public init() {
        networkManager = NetworkManager()
    }
    
}
