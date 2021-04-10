//
//  XCUIApplication.swift
//  FactsUITests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest

public enum LaunchArgument: String {

    case uiTest = "--ui-test"
    case mockDelay = "--mock-delay"
    case mockError = "--mock-error"
}

extension XCUIApplication {

    func setLaunchArguments(_ arguments: [LaunchArgument]) {
        launchArguments = arguments.map { $0.rawValue }
    }
}
