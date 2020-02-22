//
//  JSONDecoderExtensions.swift
//  ChartDownloader
//
//  Created by Reid Nantes on 2019-03-20.
//

import Foundation

public extension JSONDecoder {
    struct PublicOptions {
        public let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
        public let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy

        public init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
            self.dateDecodingStrategy = dateDecodingStrategy
            self.keyDecodingStrategy = keyDecodingStrategy
        }

        public init(dateDecodingStrategy: CustomDateFormat, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
            self.dateDecodingStrategy = .formatted(dateDecodingStrategy.format())
            self.keyDecodingStrategy = keyDecodingStrategy
        }
    }

    convenience init(options: JSONDecoder.PublicOptions) {
        self.init()
        self.dateDecodingStrategy = options.dateDecodingStrategy
        self.keyDecodingStrategy = options.keyDecodingStrategy
    }


    /// initialize JSONEncoder with a dateEncodingStrategy and prettyPrint option
    convenience init(dateDecodingStrategy customDateFormat: CustomDateFormat) {
        self.init()
        self.dateDecodingStrategy = .formatted(customDateFormat.format())
    }

    /// decode with public options
    func decode<T>(_ type: T.Type, from data: Data, options: JSONDecoder.PublicOptions = .init()) throws -> T where T: Decodable {
        let decoder = JSONDecoder.init(options: options)
        return try decoder.decode(type, from: data)
    }

    static func decode<T>(_ type: T.Type, from data: Data, options: JSONDecoder.PublicOptions = .init()) throws -> T where T: Decodable {
        let decoder = JSONDecoder.init(options: options)
        return try decoder.decode(type, from: data)
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


    /// reads json from file and decodes to value.
    func decodeFromFile<T>(_ type: T.Type, fileURL: URL, options: JSONDecoder.PublicOptions = PublicOptions.init(), readingOptions: Data.ReadingOptions = []) throws -> T where T: Decodable {
        // open file
        let fileData = try Data.init(contentsOf: fileURL, options: readingOptions)
        // decode
        return try self.decode(type, from: fileData, options: options)
    }

    /// reads json from file and decodes to value. If encoder is used more than once try using the non-static method.
    static func decodeFromFile<T>(_ type: T.Type, fileURL: URL, options: JSONDecoder.PublicOptions = PublicOptions.init(), readingOptions: Data.ReadingOptions = []) throws -> T where T: Decodable {
        // open file
        let fileData = try Data.init(contentsOf: fileURL, options: readingOptions)
        // decode
        return try Self.decode(type, from: fileData, options: options)
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

        public static func snakeCaseToPascalCaseWithCapitalizedIDTransformation(_ inputString :String) -> String {
            var newKeyStringValue = inputString.pascalCased(with: "_")
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

public extension JSONEncoder {
    struct PublicOptions {
        public let dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
        public let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
        public let outputFormatting: JSONEncoder.OutputFormatting

        public init(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate, keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys, outputFormatting: JSONEncoder.OutputFormatting = []) {
            self.dateEncodingStrategy = dateEncodingStrategy
            self.keyEncodingStrategy = keyEncodingStrategy
            self.outputFormatting = outputFormatting
        }

        public init(dateEncodingStrategy: CustomDateFormat, keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys, outputFormatting: JSONEncoder.OutputFormatting = []) {
            let dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.formatted(dateEncodingStrategy.format())
            self.init(dateEncodingStrategy: dateEncodingStrategy, keyEncodingStrategy: keyEncodingStrategy, outputFormatting: outputFormatting)
        }
    }


    /// initialize JSONEncoder with a dateEncodingStrategy and prettyPrint option
    convenience init(options: JSONEncoder.PublicOptions) {
        self.init()
        self.dateEncodingStrategy = options.dateEncodingStrategy
        self.keyEncodingStrategy = options.keyEncodingStrategy
        self.outputFormatting = options.outputFormatting
    }

    convenience init(dateEncodingStrategy customDateFormat: CustomDateFormat, isPrettyPrinted: Bool = false) {
        self.init()
        let dateFormatter = DateFormatter.init(customDateFormat: customDateFormat)
        self.dateEncodingStrategy = .formatted(dateFormatter)

        if isPrettyPrinted {
            self.outputFormatting = .prettyPrinted
        }
    }
    
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

    /// Encodes value using `JSONEncoder.PublicOptions`
    func encode<T>(_ value: T, options: JSONEncoder.PublicOptions = PublicOptions.init()) throws -> Data where T: Encodable {
        let encoder = JSONEncoder.init(options: options)
        return try encoder.encode(value)
    }

    /// Encodes value using `JSONEncoder.PublicOptions`. useful when encoder is used only once
    static func encode<T>(_ value: T, options: JSONEncoder.PublicOptions = PublicOptions.init()) throws -> Data where T: Encodable {
        let encoder = JSONEncoder.init(options: options)
        return try encoder.encode(value)
    }

    /// Encode  value to json and write to file
    func encodeToFile<T>(_ value: T, fileURL: URL, options: JSONEncoder.PublicOptions = PublicOptions.init(), writingOptions: Data.WritingOptions = []) throws where T: Encodable {
        // encode
        let data = try self.encode(value)

        // write to file
        try data.write(to: fileURL, options: writingOptions)
    }


    /// Encode  value to json and write to file. If encoder is used more than once try using the non-static method.
    static func encodeToFile<T>(_ value: T, fileURL: URL, options: JSONEncoder.PublicOptions = PublicOptions.init(), writingOptions: Data.WritingOptions = []) throws where T: Encodable {
        // encode
        let data = try Self.encode(value, options: options)
        // write to file
        try data.write(to: fileURL, options: writingOptions)
    }

}

// custom key encoding strategies
public extension JSONEncoder {
    struct CustomKeyEncodingStrategies {
        public static func camelCaseToSnakeCaseWithCapitalizedID(_ keys: [CodingKey]) -> CodingKey {
            return CustomKeyEncodingStrategyHelpers
                .convertKeys(keys, transform: CustomKeyEncodingStrategyHelpers.camelCaseToSnakeCaseTransformation)
        }
    }

    struct CustomKeyEncodingStrategyHelpers {
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

        public static func camelCaseToSnakeCaseTransformation(_ inputString :String) -> String {
            return inputString.snakeCased()
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
