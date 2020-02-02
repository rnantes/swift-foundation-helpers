//
//  ArrayExtensions.swift
//  
//
//  Created by Reid Nantes on 2019-11-15.
//

import Foundation

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        let set = Set(self.map { $0 })
        return Array(set)
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
