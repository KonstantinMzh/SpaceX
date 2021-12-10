//
//  MOThrust+CoreDataProperties.swift
//  SpaceX
//
//  Created by Константин Маламуж on 06.12.2021.
//
//

import Foundation
import CoreData
import SpaceSDK


extension MOThrust {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOThrust> {
        return NSFetchRequest<MOThrust>(entityName: "MOThrust")
    }

    @NSManaged public var kN: Int64
    @NSManaged public var lbf: Int64

    func getThrust() -> Thrust {
        return Thrust(kN: Int(kN), lbf: Int(lbf))
    }
    
}
