//
//  RegexHelper.swift
//  SwiftHTMLParser
//
//  Created by Reid Nantes on 2018-08-07.
//

import Foundation

struct RegexHelper {

    public let intWithPlusOrMinusPattern = "(-|\\+)?\\d+"
    public let doubleWithPlusOrMinusPattern = "(-|\\+)?\\d+(\\.\\d+)?"

    public func matchRanges(for regexPattern: String, inString inputString: String) -> [Range<String.Index>] {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: [.caseInsensitive]) else {
            //print("invalid regex")
            return []
        }

        let range = NSRange(inputString.startIndex..., in: inputString)
        let matches = regex.matches(in: inputString, options: [], range: range)

        var matchRanges = [Range<String.Index>]()
        for match in matches {
            matchRanges.append(Range(match.range, in: inputString)!)
        }

        return matchRanges
    }

    public func matches(for regexPattern: String, inString inputString: String) -> [String] {
        let matchRanges = self.matchRanges(for: regexPattern, inString: inputString)

        var matchingStrings = [String]()
        for range in matchRanges {
            matchingStrings.append(String(inputString[range]))
        }

        return matchingStrings
    }

    public func firstMatchRange(for regexPattern: String, inString inputString: String) -> Range<String.Index>? {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: [.caseInsensitive]) else {
            //print("Invalid Regex Pattern: \(regexPattern)")
            return nil
        }

        let range = NSRange(inputString.startIndex..., in: inputString)
        let firstMatch = regex.firstMatch(in: inputString, options: [], range: range)

        if let match = firstMatch {
            // first match found
            return Range(match.range, in: inputString)!
        } else {
            // no match found
            return nil
        }
    }

    public func firstMatch(for regexPattern: String, inString inputString: String) -> String? {
        let firstMatchRange = self.firstMatchRange(for: regexPattern, inString: inputString)

        if let range = firstMatchRange {
            // match found
            let matchingString = String(inputString[range])
            return matchingString
        } else {
            // no match found
            return nil
        }
    }

    public func hasMatch(for regexPattern: String, inString inputString: String) -> Bool {
        let firstMatchRange = self.firstMatchRange(for: regexPattern, inString: inputString)

        if firstMatchRange != nil {
            return true
        } else {
            // no match found
            return false
        }
    }

    public func replaceFirstMatch(for regexPattern: String, inString inputString: String, withString replacementString: String) -> String {
        let firstMatchRange = self.firstMatchRange(for: regexPattern, inString: inputString)

        if let range = firstMatchRange {
            // match found
            return inputString.replacingCharacters(in: range, with: replacementString)
        } else {
            // no match found
            return inputString
        }
    }

    public func replaceMatches(for regexPattern: String, inString inputString: String, withString replacementString: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: []) else {
            return inputString
        }

        let range = NSRange(inputString.startIndex..., in: inputString)
        return regex.stringByReplacingMatches(in: inputString, options: [], range: range, withTemplate: replacementString)
    }

    public func allInts(inString inputString: String) -> [Int] {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        let pattern = "(-|\\+)?\\d+"
        var matchesAsInts = [Int]()
        for matchingString in matches(for: pattern, inString: inputString) {
            matchesAsInts.append(Int(matchingString)!)
        }

        return matchesAsInts
    }

    public func firstInt(inString inputString: String) -> Int? {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        let pattern = "(-|\\+)?\\d+"
        if let matchingString = firstMatch(for: pattern, inString: inputString) {
            return Int(matchingString)
        } else {
            return nil
        }
    }

    public func allDoubles(inString inputString: String) -> [Double] {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        // (\.\d+)? -> . and digits or nothing
        let pattern = "(-|\\+)?\\d+(\\.\\d+)?"

        var matchesAsDoubles = [Double]()
        for matchingString in matches(for: pattern, inString: inputString) {
            matchesAsDoubles.append(Double(matchingString)!)
        }

        return matchesAsDoubles
    }

    public func firstDouble(inString inputString: String) -> Double? {
        // (-|\+)? -> -, + or nothing
        // \d+ -> at least one digit
        // (\.\d+)? -> . and digits or nothing
        let pattern = "(-|\\+)?\\d+(\\.\\d+)?"
        if let matchingString = firstMatch(for: pattern, inString: inputString) {
            return Double.init(matchingString)
        } else {
            return nil
        }
    }

    public func getTextBefore(firstInstanceOf pattern: String, inString inputString: String) -> String {
        if let firstMatchRange = firstMatchRange(for: pattern, inString: inputString) {
            if firstMatchRange.lowerBound > inputString.startIndex {
                return String(inputString[inputString.startIndex..<firstMatchRange.lowerBound])
            } else {
                return ""
            }
        }

        // no match or starts
        return inputString
    }

    public func getTextAfter(firstInstanceOf pattern: String, inString inputString: String) -> String {
        if let firstMatch = firstMatchRange(for: pattern, inString: inputString) {
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

    public func getTextAfter(lastInstanceOf pattern: String, inString inputString: String) -> String? {
        guard let matchRange = matchRanges(for: pattern, inString: inputString).last else {
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
