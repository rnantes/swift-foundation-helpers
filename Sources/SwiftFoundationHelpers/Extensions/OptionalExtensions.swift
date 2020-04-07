//
//  Created by Reid Nantes on 2020-04-06.
//

import Foundation

public extension Optional {
    func unwrapOrThrow(error: Error) throws -> Wrapped {
        guard let value = self else {
            throw error
        }
        return value
    }
}
