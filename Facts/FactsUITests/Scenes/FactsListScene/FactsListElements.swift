//
//  FactsListElements.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

struct FactsListElements {

    let tableView: XCUIElement
    let searchButton: XCUIElement
    let loadingView: XCUIElement
    let shareButton: XCUIElement
    let shareActivity: XCUIElement

    init() {
        let app = XCUIApplication(bundleIdentifier: "Chuck.App")
        tableView = app.tables["factsListTableView"]
        searchButton = app.navigationBars.buttons["searchButton"]
        loadingView = app.activityIndicators["factsListLoadingView"]
        shareButton = tableView.cells.firstMatch.buttons["shareButton"]
        shareActivity = app.otherElements["ActivityListView"]
    }
}
