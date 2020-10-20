//
//  DateExtensions
//  
//
//  Created by Reid Nantes on 2019-08-17.
//

import Foundation

public extension Date {
    static func now() -> Date {
        let date = Date.init()
        let roundedTimeIntervalSince1970 = date.timeIntervalSince1970.rounded(toPlaces: 3)
        return Date.init(timeIntervalSince1970: roundedTimeIntervalSince1970)
    }

    func toString(withFormat customDateFormat: CustomDateFormat) -> String {
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        return dateFormatter.string(from: self)
    }

    func toString(withFormat dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
}
