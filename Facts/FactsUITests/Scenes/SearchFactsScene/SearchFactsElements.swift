//
//  SearchFactsElements.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

struct SearchFactsElements {

    let view: XCUIElement
    let searchField: XCUIElement
    let cancelButton: XCUIElement
    let keyboardSearchKey: XCUIElement

    init() {
        let app = XCUIApplication(bundleIdentifier: "Chuck.App")
        view = app.otherElements["searchFactsView"]
        searchField = app.otherElements["searchBar"].searchFields.firstMatch
        cancelButton = app.otherElements["searchBar"].buttons.firstMatch
        keyboardSearchKey = app.keyboards.buttons["Search"]
    }
}
