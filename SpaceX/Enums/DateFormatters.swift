//
//  DateFormatters.swift
//  SpaceX
//
//  Created by Константин Маламуж on 27.10.2021.
//

import Foundation


enum DateFormatters: String {
    
    case simpleDayMonthYear = "DD.MM.YYYY"
    case dayBeforeLaunch = "D HH:mm:ss"
    
    func getDescription(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        return dateFormatter.string(from: date)
    }
    
    func getDescription(_ timeInterval: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from: date)
    }
    
}
