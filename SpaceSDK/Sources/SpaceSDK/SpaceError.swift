//
//  File.swift
//  
//
//  Created by Константин Маламуж on 29.10.2021.
//

import Foundation


public enum SpaceError: Error {
    case urlError
    case missingData
    case decodeError
}

extension SpaceError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return "URL generation error"
        case .missingData:
            return "Data receiving error"
        case .decodeError:
            return "Data conversion error"
        }
    }
    
}
