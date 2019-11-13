//
//  JSONDecoderExtensions.swift
//  ChartDownloader
//
//  Created by Reid Nantes on 2019-03-20.
//

import Foundation

public extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data, usingDateDecodingStrategy customDateFormat: CustomDateFormat) throws -> T where T: Decodable {
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateDecodingStrategy = .formatted(dateFormatter)

        return try self.decode(type, from: data)
    }

    func decode<T>(_ type: T.Type, from data: Data, usingDateDecodingStrategy dateFormat: String) throws -> T where T: Decodable {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.dateDecodingStrategy = .formatted(dateFormatter)

        return try self.decode(type, from: data)
    }
}

extension JSONEncoder {
    func encode<T>(_ value: T, usingDateEncodingStrategy customDateFormat: CustomDateFormat, isPrettyPrinted: Bool = false) throws -> Data where T: Encodable {
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if (isPrettyPrinted) {
            self.outputFormatting = .prettyPrinted
        }

        return try self.encode(value)
    }

    func encode<T>(_ value: T, usingDateEncodingStrategy dateFormat: String, isPrettyPrinted: Bool = false) throws -> Data where T: Encodable {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if (isPrettyPrinted) {
            self.outputFormatting = .prettyPrinted
        }

        return try self.encode(value)
    }

}
