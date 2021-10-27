//
//  Rocket.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


struct Rocket: Codable {
    
    let id: String
    let name: String
    let rocketDescription: String
    let firstFlight: String
    
    var firstFlightDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        let date = formatter.date(from: self.firstFlight)
        return date
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rocketDescription = "description"
        case firstFlight = "first_flight"
    }

}


extension Rocket: CustomStringConvertible {
    
    var description: String {
        return rocketDescription
    }
}
