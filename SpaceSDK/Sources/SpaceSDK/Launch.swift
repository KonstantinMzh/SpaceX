//
//  File.swift
//  
//
//  Created by Константин Маламуж on 29.10.2021.
//

import Foundation


public struct Launch: Codable {
    
    public let id: String
    public let name: String
    public let upcoming: Bool
    public let details: String?
    public let date: TimeInterval
    public let rocketId: String
    public let success: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case upcoming
        case details
        case date = "date_unix"
        case rocketId = "rocket"
        case success
    }
}

