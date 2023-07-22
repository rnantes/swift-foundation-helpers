//
//  DateHelper.swift
//  MapleWeatherForecastUpdater
//
//  Created by Reid Nantes on 2018-12-15.
//

import Foundation

public struct DateHelper {
    public let daysOfWeek: [DayOfWeek: DayOfWeekDetails] = [
        DayOfWeek.sunday: DayOfWeekDetails.init(name: "Sunday", number: 0),
        DayOfWeek.monday: DayOfWeekDetails.init(name: "Monday", number: 1),
        DayOfWeek.tuesday: DayOfWeekDetails.init(name: "Tuesday", number: 2),
        DayOfWeek.wednesday: DayOfWeekDetails.init(name: "Wednesday", number: 3),
        DayOfWeek.thursday: DayOfWeekDetails.init(name: "Thursday", number: 4),
        DayOfWeek.friday: DayOfWeekDetails.init(name: "Friday", number: 5),
        DayOfWeek.saturday: DayOfWeekDetails.init(name: "Saturday", number: 6)
    ]

    public init() {}

    public func dayOfWeekToString(_ dayOfWeek: DayOfWeek) -> String {
        return daysOfWeek[dayOfWeek]!.name
    }

    /// yyyy-MM-dd'T'HH:mm
    /// - Note: 2023-07-22
    public func isoYearMonthDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: date)
    }

    /// yyyy-MM-dd'T'HH:mm
    /// - Note: 2023-07-22T16:19
    public func date(isoDateTimeString: String, timeZone: TimeZone) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        return dateFormatter.date(from: isoDateTimeString)
    }

    /// yyyy-MM-dd'T'HH:mm:ssZZZZZ
    /// - Note: 2023-07-22T16:19:00-04:00
    public func date(isoDateTimeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        return dateFormatter.date(from: isoDateTimeString)
    }

    // isoDateString: yyyy-MM-dd
    // isoTimeString: HH:mm
    public func date(isoYearMonthDay: String, isoHourMinute: String, timeZone: TimeZone) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateString = "\(isoYearMonthDay)T\(isoHourMinute)"

        return dateFormatter.date(from: dateString)
    }

    public func isoDateString(from inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"

        return dateFormatter.string(from: inputDate)
    }

    // ex est to utc -> 2018-12-26T13:00:00-0500 to 2018-12-26T18:00:00
    public func convertToUTC(localDate: Date) -> Date? {
        let localDateString = isoDateString(from: localDate)

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"

        return dateFormatter.date(from: localDateString)
    }
}
