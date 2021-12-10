//
//  MORocket+CoreDataProperties.swift
//  SpaceX
//
//  Created by Константин Маламуж on 06.12.2021.
//
//

import Foundation
import CoreData
import SpaceSDK


extension MORocket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MORocket> {
        return NSFetchRequest<MORocket>(entityName: "MORocket")
    }

    @NSManaged public var active: Bool
    @NSManaged public var firstFlight: String?
    @NSManaged public var id: String
    @NSManaged public var images: [String]
    @NSManaged public var name: String
    @NSManaged public var rocketDescription: String?
    @NSManaged public var stages: Int16
    @NSManaged public var firstStage: MOStage?
    @NSManaged public var secondStage: MOStage?

    func getRocket() -> Rocket {
        Rocket(id: id, name: name, rocketDescription: rocketDescription, firstFlight: firstFlight, images: images, stages: Int(stages), active: active, firstStage: firstStage?.getStage(), secondStage: secondStage?.getStage())
    }
    
    
}
