//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation

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
