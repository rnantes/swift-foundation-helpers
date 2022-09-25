//
//  File.swift
//  
//
//  Created by Reid Nantes on 2020-02-22.
//

import Foundation

//
//  File.swift
//
//
//  Created by Reid Nantes on 2019-11-13.
//

import Foundation
import XCTest
import SwiftFoundationHelpers

final class StringExtensionTests: XCTestCase {
    let toSnakeCaseTests = [
        ("simpleOneTwo", "simple_one_two"),
        ("myURL", "my_url"),
        ("singleCharacterAtEndX", "single_character_at_end_x"),
        ("thisIsAnXMLProperty", "this_is_an_xml_property"),
        ("single", "single"), // no underscore
        ("", ""), // don't die on empty string
        ("a", "a"), // single character
        ("aA", "a_a"), // two characters
        ("version4Thing", "version4_thing"), // numerics
        ("partCAPS", "part_caps"), // only insert underscore before first all caps
        ("partCAPSLowerAGAIN", "part_caps_lower_again"), // switch back and forth caps.
        ("manyWordsInThisThing", "many_words_in_this_thing"), // simple lowercase + underscore + more
        ("asdfĆqer", "asdf_ćqer"),
        ("already_snake_case", "already_snake_case"),
        ("dataPoint22", "data_point22"),
        ("dataPoint22Word", "data_point22_word"),
        ("_oneTwoThree", "_one_two_three"),
        ("oneTwoThree_", "one_two_three_"),
        ("__oneTwoThree", "__one_two_three"),
        ("oneTwoThree__", "one_two_three__"),
        ("_oneTwoThree_", "_one_two_three_"),
        ("__oneTwoThree", "__one_two_three"),
        ("__oneTwoThree__", "__one_two_three__"),
        ("_test", "_test"),
        ("_test_", "_test_"),
        ("__test", "__test"),
        ("test__", "test__"),
        ("m͉̟̹y̦̳G͍͚͎̳r̤͉̤͕ͅea̲͕t͇̥̼͖U͇̝̠R͙̻̥͓̣L̥̖͎͓̪̫R̩͖̩eq͈͓u̞e̱s̙t̤̺ͅ", "m͉̟̹y̦̳_g͍͚͎̳r̤͉̤͕ͅea̲͕t͇̥̼͖_u͇̝̠r͙̻̥͓̣l̥̖͎͓̪̫_r̩͖̩eq͈͓u̞e̱s̙t̤̺ͅ"), // because Itai wanted to test this
        ("🐧🐟", "🐧🐟") // fishy emoji example?
    ]

    func testToSnakeCake() {
        for test in toSnakeCaseTests {
            let expected = test.1
            let input = test.0

            XCTAssertEqual(input.snakeCased(), expected)
        }

        let l:Character = "L̥̖͎͓̪̫"
        let lower = l.lowercased()

        let latinU:Character = "U͇̝̠"
        let latinR:Character = "R͙̻̥͓̣"
        let latinL:Character = "L̥̖͎͓̪̫"
        let latinE:Character = "É"
        XCTAssertEqual(latinU.isUppercase, true)
        XCTAssertEqual(latinR.isUppercase, true)
        XCTAssertEqual(latinL.isUppercase, true)
        XCTAssertEqual(latinE.isUppercase, true)

        XCTAssertEqual(latinU.isCased, true)
        XCTAssertEqual(latinL.isCased, true)


        // test numbers
        let string0 = "dataPoint22"
        XCTAssertEqual(string0.snakeCased(), "data_point22")

        let string1 = "whatIsLove"
        XCTAssertEqual(string1.snakeCased(), "what_is_love")

        let string2 = "whatISLove"
        XCTAssertEqual(string2.snakeCased(), "what_is_love")
    }

    func testBenchmarkConvertToSnakeCase() {
        // custom
        let startTime = Date.now
        for _ in 0..<10000 {
            for test in toSnakeCaseTests {
                var _ = String.snakeCase(test.0)
            }
        }
        let endTime = Date.now
        let elapsed = endTime.timeIntervalSince(startTime)
        print("Average Elapsed time 10000 runs: \(elapsed) seconds.")

        // stlib
        let startTime2 = Date.now
        for _ in 0..<10000 {
            for test in toSnakeCaseTests {
                var _ = String.convertToSnakeCase(test.0)
            }
        }
        let endTime2 = Date.now
        print("Average Elapsed time 10000 runs: \(elapsed) seconds.")
    }

    func testToCamelCase() {
        let string1 = "what_is_love"
        XCTAssertEqual(string1.camelCased(with: "_"), "whatIsLove")

        let string2 = "what__is__love"
        XCTAssertEqual(string2.camelCased(with: "_"), "whatIsLove")
    }

    func testToKababCase() {
        let string1 = "whatIsLove"
        XCTAssertEqual(string1.kababCased(), "what-is-love")

        let string2 = "2Fast2Furious"
        XCTAssertEqual(string2.kababCased(), "2-fast-2-furious")

        let string3 = "URLIsString"
        XCTAssertEqual(string3.kababCased(), "url-is-string")

        let string4 = "URL22IsString"
        XCTAssertEqual(string4.kababCased(), "url-22-is-string")

        let string5 = "22URLIsString"
        XCTAssertEqual(string5.kababCased(), "22-url-is-string")
    } 

}
