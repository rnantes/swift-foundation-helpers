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

    /// converts string to PascalCase
    func pascalCased(with separator: Character) -> String {
        return self.camelCased(with: separator).capitalizingFirstLetter()
    }

    /// converts a camelCased string to snake_cased
    func snakeCased() -> String {
        enum Status {
            case uppercase
            case number
            case lowercase
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
                case .number:
                    if i != self.startIndex {
                        snakeCasedString.append("_")
                    }
                case .lowercase:
                    if i != self.startIndex {
                        snakeCasedString.append("_")
                    }
                }
                status = .uppercase
                snakeCasedString.append(self[i].lowercased())
            } else if self[i].isNumber {
                switch status {
                case .number:
                    break
                case .uppercase:
                    if i != self.startIndex {
                        snakeCasedString.append("_")
                    }
                case .lowercase:
                    if i != self.startIndex {
                        snakeCasedString.append("_")
                    }
                }
                status = .number
                snakeCasedString.append(self[i])
            } else {
                status = .lowercase
                snakeCasedString.append(self[i])
            }

            i = nextIndex
        }

        return snakeCasedString
    }

    fileprivate func processCamalCaseRegex(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
    }

}
