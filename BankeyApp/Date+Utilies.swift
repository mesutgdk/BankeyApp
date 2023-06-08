//
//  Date+Utilies.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 8.06.2023.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter ()
        formatter.timeZone = TimeZone(abbreviation: "EET")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
