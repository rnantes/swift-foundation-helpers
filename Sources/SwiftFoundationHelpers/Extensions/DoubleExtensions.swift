//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation

extension Double {
    public func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
