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
    public let rocketDescription: String?
    public let firstFlight: String?
    public let images: [String]
    public let stages: Int
    public let active: Bool
    public let firstStage: Stage?
    public let secondStage: Stage?
    
    public var firstFlightDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        guard let firstFlight = firstFlight else {
            return nil
        }

        let date = formatter.date(from: firstFlight)
        return date
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active
        case rocketDescription = "description"
        case firstFlight = "first_flight"
        case images = "flickr_images"
        case stages
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
    
    public func getStages() -> [Stage] {
        [firstStage, secondStage].compactMap { $0 }
    }
    
    public init(id: String,
                name: String,
                rocketDescription: String?,
                firstFlight: String?,
                images: [String],
                stages: Int,
                active: Bool,
                firstStage: Stage?,
                secondStage: Stage?) {
        self.id = id
        self.name = name
        self.rocketDescription = rocketDescription
        self.firstFlight = firstFlight
        self.images = images
        self.stages = stages
        self.active = active
        self.firstStage = firstStage
        self.secondStage = secondStage
    }

}


public struct Stage: Codable {
    
    public let reusable: Bool?
    public let engines: Int?
    public let fuelAmountTons: Double?
    public let burnTimeSec: Int?
    public let thrustVacuum: Thrust?
    public let thrustSeaLevel: Thrust?
    public let thrust: Thrust?

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
    
    public init(reusable: Bool?,
                engines: Int?,
                fuelAmountTons: Double?,
                burnTimeSec: Int?,
                thrustVacuum: Thrust?,
                thrustSeaLevel: Thrust?,
                thrust: Thrust?) {
            
        self.reusable = reusable
        self.engines = engines
        self.fuelAmountTons = fuelAmountTons
        self.burnTimeSec = burnTimeSec
        self.thrustVacuum = thrustVacuum
        self.thrustSeaLevel = thrustSeaLevel
        self.thrust = thrust
        
    }
    
}

public struct Thrust: Codable {
    
    public let kN: Int
    public let lbf: Int

    public init(kN: Int,
                lbf: Int) {
        self.kN = kN
        self.lbf = lbf
    }
    
}
