//
//  FactListCellTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 29/03/21.
//

import XCTest
@testable import Facts

class FactListCellTests: XCTestCase {

    var sut: FactListCell!

    override func setUp() {
        sut = FactListCell()
    }

    override func tearDown() {
        sut = nil
    }

    private func createStringWith(charactersCount: UInt) -> String {
        var string = ""
        for _ in 1...charactersCount {
            string += "a"
        }
        return string
    }

    func test_FactListCell_DescriptionFontShouldBeTitle1() {
        let string = createStringWith(charactersCount: 80)

        sut.set(description: string, category: "category")

        XCTAssertLessThanOrEqual(string.count, 80)
        XCTAssertEqual(sut.infoLabel.font, UIFont.preferredFont(forTextStyle: .title1))
    }

    func test_FactListCell_DescriptionFontShouldBeTitle2() {
        let string = createStringWith(charactersCount: 81)

        sut.set(description: string, category: "category")

        XCTAssertGreaterThan(string.count, 80)
        XCTAssertEqual(sut.infoLabel.font, UIFont.preferredFont(forTextStyle: .title2))
    }

    func test_FactListCell_CategoryShouldBeUncategorized() {
        sut.set(description: "")

        XCTAssertEqual(sut.categotyLabel.text, "UNCATEGORIZED")
    }
}
