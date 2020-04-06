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

    /// ISO8601 with UTC time zone  `yyyy-MM-dd'T'HH:mm:ssZ`
    ///
    ///     DateFormatter.init(customDateFormat: .ISO8601).date(from: "2020-01-20T20:30:59Z")
    ///
    case ISO8601 = "yyyy-MM-dd'T'HH:mm:ssZ"


    /// ISO8601 with the local time zone  `yyyy-MM-dd'T'HH:mm:ssZ`
    ///
    ///     DateFormatter.init(customDateFormat: .ISO8601Local).date(from: "2020-01-20T20:30:59")
    ///
    case ISO8601Local = "yyyy-MM-dd'T'HH-mm-ss"


    case ISO8601CalendarDate = "yyyy-MM-dd"
    case ISO8601File = "yyyy-MM-dd'T'HH-mm-ssZ"


    func format() -> DateFormatter {
        return DateFormatter.init(customDateFormat: self)
    }
}
