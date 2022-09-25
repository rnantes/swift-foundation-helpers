//
//  RegexHelper.swift
//  SwiftHTMLParser
//
//  Created by Reid Nantes on 2018-08-07.
//

import Foundation
import RegexBuilder

public struct RegexHelper {

    public static let intWithPlusOrMinusPattern = "(-|\\+)?\\d+"
    public static let doubleWithPlusOrMinusPattern = "(-|\\+)?\\d+(\\.\\d+)?"

    public static func matchRanges(for regexPattern: String, inString inputString: String) throws -> [Range<String.Index>] {
        let regex = try Regex(regexPattern).ignoresCase(true)
        let matches = inputString.matches(of: regex)
        
        var matchRanges = [Range<String.Index>]()
        for match in matches {
            matchRanges.append(match.range)
        }

        return matchRanges
    }

    public static func matches(for regexPattern: String, inString inputString: String) throws -> [String] {
        let regex = try Regex(regexPattern).ignoresCase(true)
        let matches = inputString.matches(of: regex)
        let matchingStrings = matches.map({ String(inputString[$0.range]) })
        return matchingStrings
    }

    public static func firstMatchRange(for regexPattern: String, inString inputString: String) throws -> Range<String.Index>? {
        let regex = try Regex(regexPattern).ignoresCase(true)
        let match = try regex.firstMatch(in: inputString)
        return match?.range
    }

    public static func firstMatch(for regexPattern: String, inString inputString: String) throws -> String? {
        let regex = try Regex(regexPattern).ignoresCase(true)
        let match = try regex.firstMatch(in: inputString)
        guard let match else {
            // no match found
            return nil
        }
        return String(inputString[match.range])
    }

    public static func hasMatch(for regexPattern: String, inString inputString: String) throws -> Bool {
        let firstMatchRange = try self.firstMatchRange(for: regexPattern, inString: inputString)

        if firstMatchRange != nil {
            return true
        } else {
            // no match found
            return false
        }
    }

    public static func replaceFirstMatch(for regexPattern: String, inString inputString: String, withString replacementString: String) throws -> String {
        let firstMatchRange = try self.firstMatchRange(for: regexPattern, inString: inputString)

        if let range = firstMatchRange {
            // match found
            return inputString.replacingCharacters(in: range, with: replacementString)
        } else {
            // no match found
            return inputString
        }
    }

    /// returns a new string by replacing matches for given pattern with given replacement string
    public static func replaceMatches(for regexPattern: String, inString inputString: String, withString replacementString: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: []) else {
            return inputString
        }

        let range = NSRange(inputString.startIndex..., in: inputString)
        return regex.stringByReplacingMatches(in: inputString, options: [], range: range, withTemplate: replacementString)
    }

    public static func allInts(inString inputString: String) throws -> [Int] {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        let pattern = "(-|\\+)?\\d+"
        var matchesAsInts = [Int]()
        for matchingString in try matches(for: pattern, inString: inputString) {
            matchesAsInts.append(Int(matchingString)!)
        }

        return matchesAsInts
    }

    public static func firstInt(inString inputString: String) throws -> Int? {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        let pattern = "(-|\\+)?\\d+"
        if let matchingString = try firstMatch(for: pattern, inString: inputString) {
            return Int(matchingString)
        } else {
            return nil
        }
    }

    public static func allDoubles(inString inputString: String) throws -> [Double] {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        // (\.\d+)? -> . and digits or nothing
        let pattern = "(-|\\+)?\\d+(\\.\\d+)?"

        var matchesAsDoubles = [Double]()
        for matchingString in try matches(for: pattern, inString: inputString) {
            matchesAsDoubles.append(Double(matchingString)!)
        }

        return matchesAsDoubles
    }

    public static func firstDouble(inString inputString: String) -> Double? {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        // (\.\d+)? -> . and digits or nothing
        let pattern = "(-|\\+)?\\d+(\\.\\d+)?"
        if let matchingString = try? firstMatch(for: pattern, inString: inputString) {
            return Double.init(matchingString)
        } else {
            return nil
        }
    }

    public static func getTextBefore(firstInstanceOf pattern: String, inString inputString: String) throws -> String {
        if let firstMatchRange = try firstMatchRange(for: pattern, inString: inputString) {
            if firstMatchRange.lowerBound > inputString.startIndex {
                return String(inputString[inputString.startIndex..<firstMatchRange.lowerBound])
            } else {
                return ""
            }
        }

        // no match or starts
        return inputString
    }

    public static func getTextAfter(firstInstanceOf pattern: String, inString inputString: String) throws -> String {
        if let firstMatch = try firstMatchRange(for: pattern, inString: inputString) {
            let textAfterStartIndex = firstMatch.upperBound
            if textAfterStartIndex < inputString.endIndex {
                return String(inputString[textAfterStartIndex..<inputString.endIndex])
            } else {
                return ""
            }
        }

        // no match or starts
        return inputString
    }

    public static func getTextAfter(lastInstanceOf pattern: String, inString inputString: String) throws-> String? {
        guard let matchRange = try matchRanges(for: pattern, inString: inputString).last else {
            return nil
        }

        if matchRange.upperBound < inputString.endIndex {
            return String(inputString[matchRange.upperBound..<inputString.endIndex])
        } else {
            return nil
        }

        // no match or starts
//        return inputString
    }

}
