//
//  FactsUITests.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

class FactsListUITests: XCTestCase {

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

    func test_whenAppLaunchs_shouldShowSearchButton_and_factsListTable() {
        app.setLaunchArguments([.uiTest])
        app.launch()

        XCTAssertTrue(factsListElements.searchButton.exists)
        XCTAssertTrue(factsListElements.tableView.exists)
    }

    func test_whenAppLaunchs_factsListShouldBeEmpty() {
        app.setLaunchArguments([.uiTest])
        app.launch()

        XCTAssertEqual(factsListElements.tableView.cells.count, 0)
    }

    func test_whenSearchButtonTapped_shouldShowSearchScreen() {
        app.setLaunchArguments([.uiTest])
        app.launch()

        factsListElements.searchButton.tap()

        XCTAssertTrue(searchFactsElements.view.exists)
    }

    func test_whenSearchSuccess_shouldShowFacts() {
        app.setLaunchArguments([.uiTest])
        app.launch()
        factsListElements.searchButton.tap()

        searchFactsElements.searchField.typeText("query")
        searchFactsElements.keyboardSearchKey.tap()

        XCTAssertTrue(factsListElements.tableView.cells.firstMatch.exists)
    }

    func test_whenSearchSuccess_shouldshowLoadingViewThenShowFacts() {
        app.setLaunchArguments([.uiTest, .mockDelay])
        app.launch()
        factsListElements.searchButton.tap()

        searchFactsElements.searchField.typeText("query")
        searchFactsElements.keyboardSearchKey.tap()

        XCTAssertTrue(factsListElements.loadingView.exists)
        XCTAssertTrue(factsListElements.tableView.cells.firstMatch.waitForExistence(timeout: 1))
        XCTAssertFalse(factsListElements.loadingView.exists)
    }

    func test_whenFactShareButtonTapped_shouldShowShareActivity() {
        app.setLaunchArguments([.uiTest])
        app.launch()
        factsListElements.searchButton.tap()

        searchFactsElements.searchField.typeText("query")
        searchFactsElements.keyboardSearchKey.tap()

        factsListElements.shareButton.tap()
        XCTAssertTrue(factsListElements.shareActivity.waitForExistence(timeout: 1))
    }

    func test_whenSearchSuccess_shouldShowErrorAlert() {
        app.setLaunchArguments([.uiTest, .mockError])
        app.launch()
        factsListElements.searchButton.tap()

        searchFactsElements.searchField.typeText("query")
        searchFactsElements.keyboardSearchKey.tap()

        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 1))
    }
}
