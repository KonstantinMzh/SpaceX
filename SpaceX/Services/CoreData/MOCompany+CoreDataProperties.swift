//
//  MOCompany+CoreDataProperties.swift
//  SpaceX
//
//  Created by Константин Маламуж on 05.12.2021.
//
//

import Foundation
import CoreData
import SpaceSDK

extension MOCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOCompany> {
        return NSFetchRequest<MOCompany>(entityName: "MOCompany")
    }

    @NSManaged public var ceo: String?
    @NSManaged public var coo: String?
    @NSManaged public var cto: String?
    @NSManaged public var ctoPropulsion: String?
    @NSManaged public var employees: Int32
    @NSManaged public var founded: Int16
    @NSManaged public var founder: String?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    
    func getCompany() -> Company {
        let company = Company(name: ceo ?? "",
                              founder: founder ?? "",
                              founded: Int(founded),
                              employees: Int(employees),
                              ceo: ceo ?? "",
                              cto: ceo ?? "",
                              coo: coo ?? "",
                              ctoPropulsion: ctoPropulsion ?? "",
                              summary: summary ?? "")
        return company
    }

}
