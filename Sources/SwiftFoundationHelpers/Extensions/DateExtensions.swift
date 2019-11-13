//
//  DateExtensions
//  
//
//  Created by Reid Nantes on 2019-08-17.
//

import Foundation

public extension Date {
    public func toString(withFormat customDateFormat: CustomDateFormat) -> String {
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        return dateFormatter.string(from: self)
    }
}
