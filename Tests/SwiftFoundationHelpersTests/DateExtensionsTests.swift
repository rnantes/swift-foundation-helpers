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
        var formatter = DateFormatter.init(customDateFormat: .ISO8601)
        formatter.timeZone = TimeZone.init(abbreviation: "UTC")
        print(formatter.timeZone)
        let date = try XCTUnwrap(formatter.date(from: "2020-01-20T20:30:59"))
        //XCTAssertEqual(date.description.count, <#T##expression2: Equatable##Equatable#>)
    }
}
