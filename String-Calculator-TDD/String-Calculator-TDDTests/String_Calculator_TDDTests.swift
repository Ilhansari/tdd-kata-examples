//
//  String_Calculator_TDDTests.swift
//  String-Calculator-TDDTests
//
//  Created by Ilhan Sari on 16.04.2021.
//

import XCTest
@testable import String_Calculator_TDD

final class StringCalculator {

    private let separators = CharacterSet.init(charactersIn: ";,\n")

    enum negativeNumbersError: Error {
        case negativesNotAllowed
    }

    func add(_ values: String) throws -> Int {
        do {
            return try sumOfIntArray(convertStringToIntArray(values))
        } catch let error {
            throw error
        }
    }

    private func convertStringToIntArray(_ stringValue: String) -> [Int?] {
        let valuesAsStringArray = stringValue.components(separatedBy: separators)

        return valuesAsStringArray.map { Int($0) }
    }

    func sumOfIntArray(_ intArray: [Int?]) throws -> Int {
        guard intArray.filter ({ $0 == nil }).isEmpty else {
            return 0
        }

        guard intArray.filter ({ $0! < 0 }).isEmpty else {
            throw negativeNumbersError.negativesNotAllowed
        }

        return Int(intArray.reduce(0) { $0 + $1! })
    }
}

class String_Calculator_TDDTests: XCTestCase {
    func test_emptyString() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add(""), 0)
    }

    func test_singleNumberReturnSameNumber() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1"), 1)
    }

    func test_twoNumberReturnSumOfNumber() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1,2"), 3)
    }

    func test_invalidInputReturnZero() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1;2;3;"), 0)
    }

    func test_handleAmountOfNumbers() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1,2,3,4,5,6,7,8,9,10"), 55)
    }

    func test_handleNewLinesBetweenNumbers() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1\n2\n3\n4\n5\n6\n7\n8\n9\n10"), 55)
    }

    func test_handleNewLinesBetweenNumbersWithComma() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1,\n2"), 0)
    }

    func test_supportDifferentdelimiters() {
        let sut = StringCalculator()

        XCTAssertEqual(try sut.add("1;2;3;4"), 10)
    }

    func test_NegativeNumbersSupport() {
        let sut = StringCalculator()

        XCTAssertThrowsError(try sut.add("-1,-2,-3"))
    }
}
