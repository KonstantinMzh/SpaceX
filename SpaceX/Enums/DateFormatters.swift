//
//  DateFormatters.swift
//  SpaceX
//
//  Created by Константин Маламуж on 27.10.2021.
//

import Foundation


enum DateFormatters: String {
    
    case simpleDayMonthYear = "MM.DD.YYYY"
    case dayBeforeLaunch = "D HH:mm:ss"
    case monthDayAndYear = "MMMM d YYYY"
    case hourseAndMinutes = "hh:mm a"

    
    func getDescription(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        return dateFormatter.string(from: date)
    }
    
    func getDescription(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return getDescription(date)
    }
    
}


