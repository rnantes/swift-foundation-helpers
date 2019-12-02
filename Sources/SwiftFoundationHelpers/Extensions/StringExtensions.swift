//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation

public extension String {
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

    // returns a new string with a replaced suffix if the suffix exists
    func replaceSuffix(of suffix: String, with suffixToReplace: String) -> String {
        if self.hasSuffix(suffix) {
            let stringWithoutSuffix = self.dropLast(suffix.count)
            return stringWithoutSuffix.appending(suffixToReplace)
        } else {
            return String(self)
        }
    }

}
