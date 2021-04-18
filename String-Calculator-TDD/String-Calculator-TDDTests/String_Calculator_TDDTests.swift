//
//  String_Calculator_TDDTests.swift
//  String-Calculator-TDDTests
//
//  Created by Ilhan Sari on 16.04.2021.
//

import XCTest
@testable import String_Calculator_TDD

final class StringCalculator {

    private let separators = CharacterSet.init(charactersIn: ",/n")

    func add(_ values: String) -> Int {
        return sumOfIntArray(convertStringToIntArray(values))
    }

    private func convertStringToIntArray(_ stringValue: String) -> [Int?] {
        let valuesAsStringArray = stringValue.components(separatedBy: separators)
        return valuesAsStringArray.map { Int($0) }
    }

    func sumOfIntArray(_ intArray: [Int?]) -> Int {
        guard intArray.filter ({ $0 == nil }).isEmpty else {
            return 0
        }

        return Int(intArray.reduce(0) { $0 + $1! })
    }
}

class String_Calculator_TDDTests: XCTestCase {
    func test_emptyString() {
        let sut = StringCalculator()

        XCTAssertEqual(sut.add(""), 0)
    }

    func test_singleNumberReturnSameNumber() {
        let sut = StringCalculator()

        XCTAssertEqual(sut.add("1"), 1)
    }

    func test_twoNumberReturnSumOfNumber() {
        let sut = StringCalculator()

        XCTAssertEqual(sut.add("1,2"), 3)
    }

    func test_invalidInputReturnZero() {
        let sut = StringCalculator()

        XCTAssertEqual(sut.add("1;2;3;"), 0)
    }
}
