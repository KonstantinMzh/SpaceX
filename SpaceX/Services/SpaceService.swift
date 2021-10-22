//
//  SpaceService.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


protocol SpaceServiceProtocol {
    
}


class SpaceService: SpaceServiceProtocol {
    let rockets: [String: String] = [:]
    
    func parse() {
        guard let path = Bundle.main.url(forResource: "Rockets", withExtension: "json"),
              let data = try? Data(contentsOf: path)
        else { return }
        
        let decoder = JSONDecoder()
        let rocket = try? decoder.decode([Rocket].self, from: data)
    }
    
}
