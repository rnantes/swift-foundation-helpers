//
//  JSONDecoderExtensions.swift
//  ChartDownloader
//
//  Created by Reid Nantes on 2019-03-20.
//

import Foundation

public extension JSONDecoder {
    /// initialize JSONEncoder with a dateEncodingStrategy and prettyPrint option
    convenience init(dateDecodingStrategy customDateFormat: CustomDateFormat) {
        self.init()
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateDecodingStrategy = .formatted(dateFormatter)
    }

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

    /// Synchronously decode from a file
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
        public static func snakeCaseToCamelCaseWithCapitalizedID(_ keys: [CodingKey]) -> CodingKey {
            return CustomKeyDecodingStrategyHelpers
                .convertKeys(keys, transform: CustomKeyDecodingStrategyHelpers.snakeCaseToCamelCaseWithCapitalizedIDTransformation)
        }
    }

    struct CustomKeyDecodingStrategyHelpers {
        public static func convertKeys(_ keys: [CodingKey], customKeyMappings: [String: String]) -> CodingKey {
            let key = keys.last!.stringValue
            var newKeyStringValue = key
            if let customKeyMapped = customKeyMappings[key] {
                newKeyStringValue = customKeyMapped
            }

            return AnyKey(stringValue: newKeyStringValue)!
        }

        public static func convertKeys(_ keys: [CodingKey], customKeyMappings: [String: String], transform: (String) -> (String)) -> CodingKey {
            let key = keys.last!.stringValue
            var newKeyStringValue = key
            if let customKeyMapped = customKeyMappings[key] {
                newKeyStringValue = customKeyMapped
            } else {
                newKeyStringValue = transform(key)
            }

            return AnyKey(stringValue: newKeyStringValue)!
        }

        public static func convertKeys(_ keys: [CodingKey], transform: (String) -> (String)) -> CodingKey {
            let key = keys.last!.stringValue
            let newKeyStringValue = transform(key)

            return AnyKey(stringValue: newKeyStringValue)!
        }

        public static func snakeCaseToCamelCaseWithCapitalizedIDTransformation(_ inputString :String) -> String {
            var newKeyStringValue = inputString.camelCased(with: "_")
            newKeyStringValue = newKeyStringValue.replaceSuffix(of: "Id", with: "ID")
            return newKeyStringValue
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

    /// initialize JSONEncoder with a dateEncodingStrategy and prettyPrint option
    convenience init(dateEncodingStrategy customDateFormat: CustomDateFormat, isPrettyPrinted: Bool = false) {
        self.init()
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if isPrettyPrinted {
            self.outputFormatting = .prettyPrinted
        }
    }

    /// Encode  value to json and write to file
    func encodeToFile<T>(_ value: T, fileURL: URL, options: Data.WritingOptions = []) throws where T: Encodable {
        // encode
        let data = try self.encode(value)

        // write to file
        try data.write(to: fileURL, options: options)
    }

}
