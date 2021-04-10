//
//  XCUIElement.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

extension XCUIElement {

    var hasFocus: Bool {
        return (value(forKey: "hasKeyboardFocus") as? Bool) ?? false
    }
}
