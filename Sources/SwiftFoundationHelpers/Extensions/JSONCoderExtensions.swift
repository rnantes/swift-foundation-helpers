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

    // synchronously decode from a file
    func decodeFromFile<T>(_ type: T.Type, fromFile fileURL: URL, usingDateDecodingStrategy customDateFormat: CustomDateFormat) throws -> T where T: Decodable {
        // open file
        let fileData = try Data.init(contentsOf: fileURL)
        // decode
        return try self.decode(type, from: fileData, usingDateDecodingStrategy: customDateFormat)
    }
}

// custom key decoding strategies
public extension JSONDecoder {
    struct CustomKeyDecodingStrategies {
        public static func convertFromSnakeCaseWithCapitalizedID(_ keys: [CodingKey]) -> CodingKey {
            let key = keys.last!.stringValue
            var newKeyStringValue = key.camelCased(with: "_")
            newKeyStringValue = newKeyStringValue.replaceSuffix(of: "Id", with: "ID")
            return AnyKey(stringValue: newKeyStringValue)!
        }
    }

    struct AnyKey: CodingKey {
        public var stringValue: String
        public var intValue: Int?

        public init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        public init?(intValue: Int) {
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
}

extension JSONEncoder {
    public func encode<T>(_ value: T, usingDateEncodingStrategy customDateFormat: CustomDateFormat, isPrettyPrinted: Bool = false) throws -> Data where T: Encodable {
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if (isPrettyPrinted) {
            self.outputFormatting = .prettyPrinted
        }

        return try self.encode(value)
    }

    public func encode<T>(_ value: T, usingDateEncodingStrategy dateFormat: String, isPrettyPrinted: Bool = false) throws -> Data where T: Encodable {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if (isPrettyPrinted) {
            self.outputFormatting = .prettyPrinted
        }

        return try self.encode(value)
    }

}
