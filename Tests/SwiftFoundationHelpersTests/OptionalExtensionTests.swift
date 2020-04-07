//
//  Created by Reid Nantes on 2020-04-06.
//

import Foundation
import XCTest
import SwiftFoundationHelpers


final class OptionalTests: XCTestCase {
    func testUnwrapOrThrow() throws {
        let urlOptional: URL? = URL.init(string: "https://twitter.com")?.appendingPathComponent("explore")
        let url = try XCTUnwrap(try urlOptional.unwrapOrThrow(error: FoundationHelperURLError.couldNotUnwrapURL))
        XCTAssertEqual(url.absoluteString, "https://twitter.com/explore")
    }
}
