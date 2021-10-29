//
//  Rocket.swift
//  SpaceX
//
//  Created by Константин Маламуж on 22.10.2021.
//

import Foundation


public struct Rocket: Codable {
    
    public let id: String
    public let name: String
    public let rocketDescription: String
    public let firstFlight: String
    
    public var firstFlightDate: Date? {
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
    
    public var description: String {
        return rocketDescription
    }
}
