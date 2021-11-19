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
    public let images: [String]
    public let stages: Int
    let firstStage: Stage
    let secondStage: Stage
    
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
        case images = "flickr_images"
        case stages
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
    
    public func getStages() -> [Stage] {
        [firstStage, secondStage]
    }

}


public struct Stage: Codable {
    
    public let reusable: Bool?
    public let engines: Int?
    public let fuelAmountTons: Double?
    public let burnTimeSec: Int?
    let thrustVacuum: Thrust?
    let thrustSeaLevel: Thrust?
    let thrust: Thrust?

    enum CodingKeys: String, CodingKey {
        case reusable = "reusable"
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
        case thrustVacuum = "thrust_vacuum"
        case thrustSeaLevel = "thrust_sea_level"
        case thrust = "thrust"
    }
    
    public func getThrusts() -> [Thrust] {
        return [thrust, thrustVacuum, thrustSeaLevel].compactMap { $0 }
    }
    
}

public struct Thrust: Codable {
    
    public let kN: Int
    public let lbf: Int

}
