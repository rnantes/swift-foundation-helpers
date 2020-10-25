//
//  Created by Reid Nantes on 2020-10-25.
//

import Foundation
import XCTest
import SwiftFoundationHelpers

final class JSONEncoderExtensionsTests: XCTestCase {
    struct SomeTestStruct: Codable {
        var timestamp = Date.now()
        var name = "Bob"
        var age = 12
    }

    func testEncodeiso8601() throws {
        let jsonEncoder = JSONEncoder.init(dateEncodingStrategy: .iso8601withFractionalSeconds)
        let encodedStruct = try jsonEncoder.encode(SomeTestStruct())
        XCTAssertNotNil(encodedStruct)

        let jsonEncoder2 = JSONEncoder.init(dateEncodingStrategy: .iso8601)
        let encodedStruct2 = try jsonEncoder2.encode(SomeTestStruct())
        XCTAssertNotNil(encodedStruct2)
    }
}
