//
//  DateFormatHelper.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/13/21.
//

import Foundation

class DateFormatHelper {
    
    static let shared = DateFormatHelper()

    public func stringToDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: date)
    }
    
    public func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mma"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }
}
