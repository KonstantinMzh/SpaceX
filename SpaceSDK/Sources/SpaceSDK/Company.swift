//
//  File.swift
//  
//
//  Created by Константин Маламуж on 23.11.2021.
//

import Foundation


public struct Company: Codable {
    
    public let name: String
    public let founder: String
    public let founded: Int
    public let employees: Int
    public let ceo: String
    public let cto: String
    public let coo: String
    public let ctoPropulsion: String
    public let summary: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case ceo
        case cto
        case coo
        case ctoPropulsion = "cto_propulsion"
        case summary
    }
}
