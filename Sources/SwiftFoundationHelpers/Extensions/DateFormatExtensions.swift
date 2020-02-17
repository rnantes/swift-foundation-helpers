//
//  DateFormatExtensions.swift
//  MapleWeatherParser
//
//  Created by Reid Nantes on 2019-07-21.
//

import Foundation

public extension DateFormatter {
    convenience init(customDateFormat: CustomDateFormat) {
        self.init()
        self.dateFormat = customDateFormat.rawValue
    }
}

public enum CustomDateFormat: String {
    case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ISO8601CalendarDate = "yyyy-MM-dd"
    case ISO8601File = "yyyy-MM-dd'T'HH-mm-ssZ"

    func format() -> DateFormatter {
        return DateFormatter.init(customDateFormat: self)
    }
}
