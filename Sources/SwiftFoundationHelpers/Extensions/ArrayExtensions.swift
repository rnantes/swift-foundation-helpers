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
