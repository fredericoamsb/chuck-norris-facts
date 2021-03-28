//
//  FactListCellTests.swift
//  SearchChuckNorrisFactsTests
//
//  Created by Frederico Augusto on 27/03/21.
//

import XCTest
@testable import SearchChuckNorrisFacts

class FactListCellTests: XCTestCase {

    private func createStringWith(charactersCount: UInt) -> String {
        var string = ""
        for _ in 1...charactersCount {
            string += "a"
        }
        return string
    }

    func test_FactListCell_DescriptionFontShouldBeTitle1() {
        let sut = FactListCell()
        let string = createStringWith(charactersCount: 80)

        sut.set(description: string, category: "category")

        XCTAssert(string.count <= 80)
        XCTAssert(sut.infoLabel.font == UIFont.preferredFont(forTextStyle: .title1))
    }

    func test_FactListCell_DescriptionFontShouldBeTitle2() {
        let sut = FactListCell()
        let string = createStringWith(charactersCount: 81)

        sut.set(description: string, category: "category")

        XCTAssert(string.count > 80)
        XCTAssert(sut.infoLabel.font == UIFont.preferredFont(forTextStyle: .title2))
    }

    func test_FactListCell_CategoryShouldBeUncategorized() {
        let sut = FactListCell()

        sut.set(description: "", category: nil)

        XCTAssert(sut.categotyLabel.text == "UNCATEGORIZED")
    }
}
