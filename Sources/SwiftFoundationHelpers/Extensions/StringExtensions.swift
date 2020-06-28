//
//  File.swift
//  
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation

public extension String {
    struct SpecialCharacters {
        public static let newline = "\n"
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

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

    /// returns a new string with a replaced suffix if the suffix exists
    func replaceSuffix(of suffix: String, with suffixToReplace: String) -> String {
        if self.hasSuffix(suffix) {
            let stringWithoutSuffix = self.dropLast(suffix.count)
            return stringWithoutSuffix.appending(suffixToReplace)
        } else {
            return String(self)
        }
    }

    /// converts string to camelCased
    func camelCased(with separator: Character) -> String {
        return self.lowercased()
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }

    /// converts string to kabab-case
    func kababCased() -> String {
        enum Status {
            case uppercase
            case lowercase
            case number
            case notAvailable
        }

        func getStatusOfChar(_ char: Character?) -> Status {
            guard let char = char else {
                return .notAvailable
            }
            if char.isNumber {
                return Status.number
            } else {
                if char.isUppercase {
                    return .uppercase
                } else {
                    return .lowercase
                }
            }
        }

        let seperator = "-"
        var transformedString = "" // the kabab cased string

        var prevStatus = Status.notAvailable
        var curStatus = Status.notAvailable
        var isInChain = false

        var i = self.startIndex
        while i < self.endIndex {
            // prev char
            prevStatus = curStatus
            // cur char
            let currentChar = self[i]
            curStatus = getStatusOfChar(currentChar)
            // next char
            let nextIndex = self.index(i, offsetBy: 1)
            var nextChar: Character? = nil
            if (nextIndex < self.endIndex) {
                nextChar = self[nextIndex]
            }
            let nextStatus = getStatusOfChar(nextChar)

            switch curStatus {
            case .uppercase:
                if (prevStatus != .notAvailable && prevStatus != .uppercase) ||
                    (prevStatus != .notAvailable && prevStatus == .uppercase && nextStatus == .lowercase) {
                    transformedString.append(seperator)
                }
                isInChain = true
                transformedString.append(currentChar.lowercased())
            case .number:
                if (prevStatus != .notAvailable && prevStatus != .number) ||
                    (prevStatus != .notAvailable && prevStatus == .number && nextStatus == .lowercase) {
                    transformedString.append(seperator)
                }
                isInChain = true
                transformedString.append(currentChar)
            case .lowercase:
                isInChain = false
                transformedString.append(currentChar)
            case .notAvailable:
                break
            }

            i = nextIndex
        }

        return transformedString
    }

    /// converts string to PascalCase
    func pascalCased(with separator: Character) -> String {
        return self.camelCased(with: separator).capitalizingFirstLetter()
    }

    /// converts a camelCased string to snake_cased
    func snakeCased() -> String {
        enum Status {
            case uppercase
            case lowercase
            case number
        }

        var status = Status.lowercase
        var snakeCasedString = ""
        var i = self.startIndex
        while i < self.endIndex {
            let nextIndex = self.index(i, offsetBy: 1)

            if self[i].isUppercase {
                switch status {
                case .uppercase:
                    if nextIndex < self.endIndex {
                        if self[nextIndex].isLowercase {
                            snakeCasedString.append("_")
                        }
                    }
                case .lowercase,
                     .number:
                    if i != self.startIndex {
                        snakeCasedString.append("_")
                    }
                }
                status = .uppercase
                snakeCasedString.append(self[i].lowercased())
            } else {
                status = .lowercase
                snakeCasedString.append(self[i])
            }

            i = nextIndex
        }

        return snakeCasedString
    }

    static func snakeCase(_ stringKey: String) -> String {
        guard !stringKey.isEmpty else { return stringKey }
        
        enum Status {
            case uppercase
            case lowercase
            case number
        }

        var status = Status.lowercase
        var snakeCasedString = ""
        var i = stringKey.startIndex
        while i < stringKey.endIndex {
            let nextIndex = stringKey.index(i, offsetBy: 1)

            if stringKey[i].isUppercase {
                switch status {
                case .uppercase:
                    if nextIndex < stringKey.endIndex {
                        if stringKey[nextIndex].isLowercase {
                            snakeCasedString.append("_")
                        }
                    }
                case .lowercase,
                     .number:
                    if i != stringKey.startIndex {
                        snakeCasedString.append("_")
                    }
                }
                status = .uppercase
                snakeCasedString.append(stringKey[i].lowercased())
            } else {
                status = .lowercase
                snakeCasedString.append(stringKey[i])
            }

            i = nextIndex
        }

        return snakeCasedString
    }


    // source https://github.com/apple/swift/blob/master/stdlib/public/Darwin/Foundation/JSONEncoder.swift
    static func convertToSnakeCase(_ stringKey: String) -> String {
        guard !stringKey.isEmpty else { return stringKey }

        var words : [Range<String.Index>] = []
        // The general idea of this algorithm is to split words on transition from lower to upper case, then on transition of >1 upper case characters to lowercase
        //
        // myProperty -> my_property
        // myURLProperty -> my_url_property
        //
        // We assume, per Swift naming conventions, that the first character of the key is lowercase.
        var wordStart = stringKey.startIndex
        var searchRange = stringKey.index(after: wordStart)..<stringKey.endIndex

        // Find next uppercase character
        while let upperCaseRange = stringKey.rangeOfCharacter(from: CharacterSet.uppercaseLetters, options: [], range: searchRange) {
            let untilUpperCase = wordStart..<upperCaseRange.lowerBound
            words.append(untilUpperCase)

            // Find next lowercase character
            searchRange = upperCaseRange.lowerBound..<searchRange.upperBound
            guard let lowerCaseRange = stringKey.rangeOfCharacter(from: CharacterSet.lowercaseLetters, options: [], range: searchRange) else {
                // There are no more lower case letters. Just end here.
                wordStart = searchRange.lowerBound
                break
            }

            // Is the next lowercase letter more than 1 after the uppercase? If so, we encountered a group of uppercase letters that we should treat as its own word
            let nextCharacterAfterCapital = stringKey.index(after: upperCaseRange.lowerBound)
            if lowerCaseRange.lowerBound == nextCharacterAfterCapital {
                // The next character after capital is a lower case character and therefore not a word boundary.
                // Continue searching for the next upper case for the boundary.
                wordStart = upperCaseRange.lowerBound
            } else {
                // There was a range of >1 capital letters. Turn those into a word, stopping at the capital before the lower case character.
                let beforeLowerIndex = stringKey.index(before: lowerCaseRange.lowerBound)
                words.append(upperCaseRange.lowerBound..<beforeLowerIndex)

                // Next word starts at the capital before the lowercase we just found
                wordStart = beforeLowerIndex
            }
            searchRange = lowerCaseRange.upperBound..<searchRange.upperBound
        }
        words.append(wordStart..<searchRange.upperBound)
        let result = words.map({ (range) in
            return stringKey[range].lowercased()
        }).joined(separator: "_")
        return result
    }

    fileprivate func processCamalCaseRegex(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
    }

}
