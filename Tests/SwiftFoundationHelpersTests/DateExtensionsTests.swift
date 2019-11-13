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

    static var allTests = [
        ("testDateFormat", testDateFormat),
    ]
}
