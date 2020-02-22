//
//  File.swift
//  
//
//  Created by Reid Nantes on 2020-02-22.
//

import Foundation

//
//  File.swift
//
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation
import XCTest
import SwiftFoundationHelpers

final class StringExtensionTests: XCTestCase {
    func testToSnakeCake() {
        let string1 = "whatIsLove"
        XCTAssertEqual(string1.snakeCased(), "what_is_love")

        let string2 = "whatISLove"
        XCTAssertEqual(string2.snakeCased(), "what_is_love")
    }
}
