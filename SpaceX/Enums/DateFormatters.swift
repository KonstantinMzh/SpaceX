//
//  DateFormatters.swift
//  SpaceX
//
//  Created by Константин Маламуж on 27.10.2021.
//

import Foundation


enum DateFormatters: String {
    
    case simpleDayMonthYear = "DD.MM.YYYY"
    
    func getDescriptionFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        return dateFormatter.string(from: date)
    }
    
    
    
}
