//
//  Date+Extension.swift
//  SpaceX
//
//  Created by Константин Маламуж on 12.11.2021.
//

import Foundation

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
