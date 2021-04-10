//
//  SearchFactsUITests.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

class SearchFactsUITests: XCTestCase {

    var app: XCUIApplication!
    var factsListElements: FactsListElements!
    var searchFactsElements: SearchFactsElements!

    override func setUp() {
        app = XCUIApplication(bundleIdentifier: "Chuck.App")
        factsListElements = FactsListElements()
        searchFactsElements = SearchFactsElements()
    }

    override func tearDown() {
        app = nil
        factsListElements = nil
        searchFactsElements = nil
    }

    func test_whenSearchFactsAppear_shouldShowSearchField_and_cancelButton() {
        launchAndTapSearchButton()
        XCTAssertTrue(searchFactsElements.searchField.exists)
        XCTAssertTrue(searchFactsElements.cancelButton.exists)
    }

    func test_whenSearchFactsAppear_shouldFocusSearchField() {
        launchAndTapSearchButton()
        XCTAssertTrue(searchFactsElements.searchField.waitForExistence(timeout: 1))
        XCTAssertTrue(searchFactsElements.searchField.hasFocus)
    }

    func test_whenCancelButtonTapped_shouldBackToFactsListScreen() {
        launchAndTapSearchButton()
        searchFactsElements.cancelButton.tap()

        XCTAssertFalse(searchFactsElements.view.exists)
        XCTAssertTrue(factsListElements.searchButton.isHittable)
    }

    func test_whenKeyboardSearchKeyTapped_withEmptySearchField_shouldDoNothing() {
        launchAndTapSearchButton()
        searchFactsElements.keyboardSearchKey.tap()

        XCTAssertTrue(app.keyboards.firstMatch.exists)
    }

    private func launchAndTapSearchButton() {
        app.setLaunchArguments([.uiTest])
        app.launch()
        factsListElements.searchButton.tap()
    }
}
