//
//  DateExtensions
//  
//
//  Created by Reid Nantes on 2019-08-17.
//

import Foundation


public extension Date {

    static func now() -> Date {
        let _microsecondsPerSecond: Int64 = 1_000_000
        let _secondsInDay: Int64 = 24 * 60 * 60
        let _psqlDateStart = Date(timeIntervalSince1970: 946_684_800) // values are stored as seconds before or after midnight 2000-01-01
        
        let seconds = Date.init().timeIntervalSince(_psqlDateStart) * Double(_microsecondsPerSecond)
        let microseconds = seconds
        let secondsFinal = Double(microseconds) / Double(_microsecondsPerSecond)
        let now = Date(timeInterval: secondsFinal, since: _psqlDateStart)
        return now
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
