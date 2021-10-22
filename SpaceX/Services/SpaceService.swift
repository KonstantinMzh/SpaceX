//
//  SpaceService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


protocol SpaceServiceProtocol {
    func getRocketsTitles() -> [String]
    func getRocketsCount() -> Int
    func getRocketByIndex(_ index: Int) -> Rocket
}


class SpaceService: SpaceServiceProtocol {
    
    var rockets = [Rocket]()
    
    private func fetch() {
        
        guard let path = Bundle.main.url(forResource: "Rockets", withExtension: "json"),
              let data = try? Data(contentsOf: path)
        else { return }
        
        let decoder = JSONDecoder()
        guard var rockets = try? decoder.decode([Rocket].self, from: data) else { return }
        
        rockets.sort {
            $0.firstFlightDate > $1.firstFlightDate
        }
        
        self.rockets = rockets
        print(self.rockets)
        
    }
    
    func getRocketsTitles() -> [String] {
        rockets.map { $0.name }
    }
    
    func getRocketsCount() -> Int {
        rockets.count
    }
    
    func getRocketByIndex(_ index: Int) -> Rocket {
        rockets[index]
    }
    
}
