//
//  DayOfWeekDetails.swift
//  MapleWeatherParser
//
//  Created by Reid Nantes on 2018-12-30.
//

import Foundation

public struct DayOfWeekDetails {
    var name: String
    var number: Int

    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}
