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
    
    public init(name: String,
                founder: String,
                founded: Int,
                employees: Int,
                ceo: String,
                cto: String,
                coo: String,
                ctoPropulsion: String,
                summary: String) {
        self.ceo = ceo
        self.coo = coo
        self.cto = cto
        self.ctoPropulsion = ctoPropulsion
        self.employees = employees
        self.founded = founded
        self.founder = founder
        self.name = name
        self.summary = summary
    }
    
}
