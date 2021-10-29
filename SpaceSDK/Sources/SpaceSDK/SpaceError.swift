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
            return "Ошибка генерации URL"
        case .missingData:
            return "Ошибка при получении данных"
        case .decodeError:
            return "Ошибка преобразования данных"
        }
    }
    
}
