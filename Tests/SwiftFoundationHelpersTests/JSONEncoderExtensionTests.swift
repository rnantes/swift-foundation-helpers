//
//  Created by Reid Nantes on 2020-10-25.
//

import Foundation
import XCTest
import SwiftFoundationHelpers

final class JSONEncoderExtensionsTests: XCTestCase {
    struct SomeTestStruct: Codable, Equatable {
        var timestamp = Date.now()
        var name = "Bob"
        var age = 12
    }

    func testEncodeiso8601() throws {
        let testStruct = SomeTestStruct()
        let jsonEncoder = JSONEncoder.init(dateEncodingStrategy: .iso8601withFractionalSeconds)
        let encodedStruct = try jsonEncoder.encode(testStruct)
        XCTAssertNotNil(encodedStruct)

        let jsonDecoder = JSONDecoder.init(dateDecodingStrategy: .iso8601withFractionalSeconds)
        let decodedStruct = try jsonDecoder.decode(SomeTestStruct.self, from: encodedStruct)



        // this doesn't format the dates correctly
        let testStruct2 = SomeTestStruct()
        let jsonEncoder2 = JSONEncoder.init(dateEncodingStrategy: .iso8601)
        let encodedStruct2 = try jsonEncoder2.encode(testStruct)
        XCTAssertNotNil(encodedStruct2)

        let jsonDecoder2 = JSONDecoder.init(dateDecodingStrategy: .iso8601)
        let decodedStruct2 = try jsonDecoder2.decode(SomeTestStruct.self, from: encodedStruct2)

        XCTAssertNotEqual(testStruct2.timestamp, decodedStruct2.timestamp)
    }
}
