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


extension Date {
    
    func getRemainTimeBeforeEvent(eventDate: TimeInterval) -> String {
        
        let currentDate = changeToSystemTimeZone(self).timeIntervalSince1970
                
        let diff = eventDate - currentDate
        
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date(timeIntervalSince1970: diff))
        
        var result = ""
        
        if let day = dateComponent.day, day <= 2 {
            result = DateFormatters.dayBeforeLaunch.getDescription(diff)
        }

        if let day = dateComponent.day, day == 2 {
            result = "\(day) day"
        }

        if let days = dateComponent.day, days >= 2 {
            result = "\(days) days"
        }

        if let month = dateComponent.month, month == 2 {
            result = "\(month) month"
        }

        if let months = dateComponent.month, months >= 2 {
            result = "\(months) months"
        }

        if let year = dateComponent.year, year == 2 {
            result = "\(year) year"
        }

        if let years = dateComponent.year, years == 2 {
            result = "\(years) years"
        }
        
        return result

    }
    
    func changeToSystemTimeZone(_ date: Date) -> Date {
        guard let fromTimeZone = TimeZone(abbreviation: "UTC") else { return self }
        let sourceOffset = fromTimeZone.secondsFromGMT(for: date)
        let destinationOffset = TimeZone.current.secondsFromGMT(for: date)
        let timeInterval = TimeInterval(destinationOffset - sourceOffset)
        return Date(timeInterval: timeInterval, since: date)
    }
    
    
}
