//
//  StringHelper.swift
//  MapleWeatherForecastUpdater
//
//  Created by Reid Nantes on 2018-12-15.
//

import Foundation

struct StringHelper {
    func containsAtLeastOneKeyword(inputString: String, keywords: [String]) -> Bool {
        for keyword in keywords {
            if inputString.contains(keyword) {
                return true
            }
        }

        return false
    }
}

extension String {
    func startsCaseInsensitive(with: String) -> Bool {
        return self.lowercased().starts(with: with)
    }

    func containsAtLeastOneKeyword(_ keywords: [String]) -> Bool {
        for keyword in keywords {
            if self.contains(keyword) {
                return true
            }
        }
        return false
    }

}
