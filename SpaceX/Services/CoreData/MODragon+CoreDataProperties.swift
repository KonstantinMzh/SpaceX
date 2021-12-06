//
//  MODragon+CoreDataProperties.swift
//  SpaceX
//
//  Created by Константин Маламуж on 06.12.2021.
//
//

import Foundation
import CoreData
import SpaceSDK

extension MODragon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MODragon> {
        return NSFetchRequest<MODragon>(entityName: "MODragon")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var dragonDescription: String
    @NSManaged public var firstFight: String
    @NSManaged public var images: [String]
    @NSManaged public var active: Bool
    
    func getDragon() -> Dragon {
        Dragon(id: id, name: name, dragonDescription: dragonDescription, firstFlight: firstFight, images: images, active: active)
    }
    
}
