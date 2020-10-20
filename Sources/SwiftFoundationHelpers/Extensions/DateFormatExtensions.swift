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

    /// ISO8601 with the local time zone  `yyyy-MM-dd'T'HH:mm:ssZ`
    ///
    ///     DateFormatter.init(customDateFormat: .ISO8601Micros).date(from: "2020-01-20T20:30:59.636507")
    ///
    case ISO8601Micros = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXX"

    case ISO8601CalendarDate = "yyyy-MM-dd"
    case ISO8601File = "yyyy-MM-dd'T'HH-mm-ssZ"


    func format() -> DateFormatter {
        return DateFormatter.init(customDateFormat: self)
    }
}


@available(OSX 10.12, *)
extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

//extension Formatter {
//    static let iso8601withFractionalSeconds: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
//        return formatter
//    }()
//}

@available(OSX 10.13, *)
public extension Formatter {
    static let iso8601withFractionalSeconds: ISO8601DateFormatter  = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

@available(OSX 10.13, *)
public extension Date {
    var iso8601withFractionalSeconds: String? { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}

@available(OSX 10.13, *)
public extension String {
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
}

@available(OSX 10.13, *)
public extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid date: " + string)
        }
        return date
    }
}

@available(OSX 10.13, *)
public extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}
