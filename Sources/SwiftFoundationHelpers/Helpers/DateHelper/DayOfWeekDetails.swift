//
//  DayOfWeekDetails.swift
//  MapleWeatherParser
//
//  Created by Reid Nantes on 2018-12-30.
//

import Foundation

public struct DayOfWeekDetails {
    public var name: String
    public var number: Int

    public init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}
