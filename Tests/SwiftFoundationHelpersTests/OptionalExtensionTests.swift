//
//  Created by Reid Nantes on 2020-04-06.
//

import Foundation
import XCTest
import SwiftFoundationHelpers


final class OptionalTests: XCTestCase {
    func testUnwrapOrThrow() {
        let urlOptional: URL? = URL.init(string: "https://twitter.com")?.appendingPathComponent("explore")
        XCTAssertNoThrow(try urlOptional.unwrapOrThrow(error: FoundationHelperURLError.couldNotUnwrapURL))
    }
}
