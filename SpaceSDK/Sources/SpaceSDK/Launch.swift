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
    public var links: LaunchLinks? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case upcoming
        case details
        case date = "date_unix"
        case rocketId = "rocket"
        case success
        case links
    }
    
    public init(id: String,
         name: String,
         upcoming: Bool,
         details: String?,
         date: TimeInterval,
         rocketId: String,
         success: Bool?,
         links: LaunchLinks) {
        self.id = id
        self.name = name
        self.upcoming = upcoming
        self.details = details
        self.date = date
        self.rocketId = rocketId
        self.success = success
        self.links = links
    }
    
}



public struct LaunchLinks: Codable {
    
    public let flickr: LaunchFlickr?
    
    public init(flickr: LaunchFlickr) {
        self.flickr = flickr
    }
    
}


public struct LaunchFlickr: Codable {
    
    public let original: [String]
    
    public init(original: [String]) {
        self.original = original
    }
    
}
