//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation
import XCTest
import SwiftFoundationHelpers

final class DateExtensionsTests: XCTestCase {
    func testDateFormat() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let dayOfWeek = DayOfWeek.friday
        XCTAssertEqual(dayOfWeek.rawValue, "friday")
    }

    func testDateFormatISO8601Local() throws {
        var formatter = DateFormatter.init(customDateFormat: .ISO8601Local)
        formatter.timeZone = TimeZone.init(abbreviation: "UTC")
        print(formatter.timeZone)
        let date = try XCTUnwrap(formatter.date(from: "2020-01-20T20:30:59"))
        //XCTAssertEqual(date.description.count, <#T##expression2: Equatable##Equatable#>)
    }

    func testDateFormatISO8601Micros() throws {
        //var formatter = DateFormatter.init(customDateFormat: .ISO8601Micros)
        var formatter = DateFormatter.init(customDateFormat: .ISO8601Micros)
        formatter.timeZone = TimeZone.init(abbreviation: "UTC")
        formatter.locale = Locale(identifier: "en_US_POSIX")

        print(formatter.string(from: Date()))
        //let date = formatter.date(from: "2020-01-20T20:30:59.1051378Z")
        let date = formatter.date(from: "2020-10-20T02:58:14.1234+0000")
        XCTAssertNotNil(date)

        print(formatter.string(from: date!))
        //let date = try XCTUnwrap()

        print("--------")
        let string1 = "2018-05-10T21:41:30Z"
        let string2 = "2018-05-10T21:41:54634Z"
        let dateString1 = formatter.date(from: string1)
        let dateString2 = formatter.date(from: string2)

        print(dateString1?.timeIntervalSince1970)
        print(dateString1?.timeIntervalSinceReferenceDate)

        print("String2 -------")
        print(dateString2?.timeIntervalSince1970)
        print(dateString2?.timeIntervalSinceReferenceDate)
        print("++++++++++")
    }

    func testISO8601DateFormatter() {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = .current

        //let now = Date.init()
        let now = Date.now()

        let dateString = now.iso8601withFractionalSeconds!
        let read = dateString.iso8601withFractionalSeconds!

        XCTAssertEqual(now.timeIntervalSince1970, read.timeIntervalSince1970)
        XCTAssertEqual(now.timeIntervalSinceReferenceDate, read.timeIntervalSinceReferenceDate)
        XCTAssertEqual(now, read)
    }

}
