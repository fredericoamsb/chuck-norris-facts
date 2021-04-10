//
//  LaunchArgument.swift
//  Domain
//
//  Created by Frederico Augusto on 10/04/21.
//

public enum LaunchArguments: String {

    case uiTest = "--ui-test"
    case mockDelay = "--mock-delay"
    case mockError = "--mock-error"

    public static func contains(_ argument: LaunchArguments) -> Bool {
        CommandLine.arguments.contains(argument.rawValue)
    }
}
