//
//  StageProperty.swift
//  SpaceX
//
//  Created by Константин Маламуж on 19.11.2021.
//

import Foundation


enum StageProperty: String {
    
    case fuelAmount = "Fuel Amount"
    case burnTime = "Burn Time"
    case enginesNumber = "Number of Engines"
    case reusable = "Reusable"
    
    func getMeasurementUnit() -> MeasurementUnit? {
        switch self {
        case .fuelAmount:
            return .tons
        case .burnTime:
            return .sec
        case .enginesNumber:
            return nil
        case .reusable:
            return nil
        }
    }
    
}
