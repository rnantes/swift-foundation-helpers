//
//  DateExtensions
//  
//
//  Created by Reid Nantes on 2019-08-17.
//

import Foundation

public extension Date {
    private static let sharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS Z"
        return dateFormatter
    }()
    
    #if os(Linux) && swift(<5.8)
    static var now: Date {
        return Date()
    }
    #endif

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
