//
//  SpaceService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


public protocol SpaceServiceProtocol {
    func getRocketsTitles() -> [String]
    func getRocketsCount() -> Int
    func getRocketByIndex(_ index: Int, completion: @escaping (Result<Rocket, Error>) -> Void)
}


public class SpaceService: SpaceServiceProtocol {
    
    var rockets = [Rocket]()
    
    private func fetch() {
        
        guard let path = Bundle.module.url(forResource: "Rockets", withExtension: "json"),
              let data = try? Data(contentsOf: path)
        else { return }
        
        let decoder = JSONDecoder()
        guard var rockets = try? decoder.decode([Rocket].self, from: data) else { return }
        
        rockets.sort {
            $0.firstFlightDate ?? Date() > $1.firstFlightDate ?? Date()
        }
        
        self.rockets = rockets
        print(self.rockets)
        
    }
    
    public func getRocketsTitles() -> [String] {
        rockets.map { $0.name }
    }
    
    public func getRocketsCount() -> Int {
        rockets.count
    }
    
    public func getRocketByIndex(_ index: Int, completion: (Result<Rocket, Error>) -> Void) {
        completion(.success(rockets[index]))
    }
    
    public init() {
        fetch()
    }
    
}
