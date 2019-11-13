//
//  DoubleHelper.swift
//  MapleWeatherParser
//
//  Created by Reid Nantes on 2018-12-31.
//

import Foundation

struct DoubleHelper {
    func round(number: Double, toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (number * divisor).rounded() / divisor
    }
}
