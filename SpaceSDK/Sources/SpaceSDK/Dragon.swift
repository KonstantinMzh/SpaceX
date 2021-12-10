//
//  File.swift
//  
//
//  Created by Константин Маламуж on 20.11.2021.
//

import Foundation



public struct Dragon: Codable {
    
    public let id: String
    public let name: String
    public let dragonDescription: String
    public let firstFlight: String
    public let images: [String]
    public let active: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dragonDescription = "description"
        case firstFlight = "first_flight"
        case images = "flickr_images"
        case active
    }
    
    public init(id: String,
         name: String,
         dragonDescription: String,
         firstFlight: String,
         images: [String],
         active: Bool) {
        self.id = id
        self.name = name
        self.dragonDescription = dragonDescription
        self.firstFlight = firstFlight
        self.images = images
        self.active = active
    }
    
}
