//
//  AppDelegate.swift
//  App
//
//  Created by Frederico Augusto on 30/03/21.
//

import UIKit
import AlamofireNetworkActivityLogger
import Domain

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        setupNetworkLogger()
        setupUITests()
        #endif

        return true
    }

    private func setupNetworkLogger() {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }

    private func setupUITests() {
        if LaunchArguments.contains(.uiTest) {
            UIView.setAnimationsEnabled(false)
        }

        #if targetEnvironment(simulator)
        // Disable hardware keyboard
        let setHardwareLayout = NSSelectorFromString("setHardwareLayout:")
        UITextInputMode.activeInputModes
            .filter({ $0.responds(to: setHardwareLayout) })
            .forEach { $0.perform(setHardwareLayout, with: nil) }
        #endif
    }
}
