//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-08-11.
//

import Foundation

public extension Data {
    func printAsString() {
        guard let dataAsString = self.toString() else {
            print("ERROR: Could not convert data to string")
            return
        }

        print(dataAsString)
    }

    func toString(encoding: String.Encoding = String.Encoding.utf8) -> String? {
        return String.init(data: self, encoding: encoding)
    }
}
