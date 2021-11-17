//
//  EquipmentsType.swift
//  SpaceX
//
//  Created by Константин Маламуж on 14.11.2021.
//

import Foundation

enum EquipmentsType {

    case rocket
    case capsule
    
    func getEquipment() -> Equipment {
        switch self {
        case .rocket:
            return Equipment(name: "Rockets", coverName: "rocketCover")
            
        case .capsule:
            return Equipment(name: "Dragons", coverName: "capsuleCover")
        }
    }
    
}
