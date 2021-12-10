//
//  MOStage+CoreDataProperties.swift
//  SpaceX
//
//  Created by Константин Маламуж on 06.12.2021.
//
//

import Foundation
import CoreData
import SpaceSDK

extension MOStage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOStage> {
        return NSFetchRequest<MOStage>(entityName: "MOStage")
    }

    @NSManaged public var reusable: Bool
    @NSManaged public var engines: Int32
    @NSManaged public var fuelAmountTons: Double
    @NSManaged public var burnTimeSec: Int64
    @NSManaged public var thrustVacuum: MOThrust?
    @NSManaged public var thrustSeaLevel: MOThrust?
    @NSManaged public var thrust: MOThrust?

    func getStage() -> Stage {
        let stage = Stage(reusable: reusable, engines: Int(engines), fuelAmountTons: fuelAmountTons, burnTimeSec: Int(burnTimeSec), thrustVacuum: thrustVacuum?.getThrust(), thrustSeaLevel: thrustSeaLevel?.getThrust(), thrust: thrust?.getThrust())
        return stage
    }
    
}
