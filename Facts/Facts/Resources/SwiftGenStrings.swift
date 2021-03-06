// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum FactCell {
    internal enum Category {
      /// UNCATEGORIZED
      internal static let uncategorized = L10n.tr("Localizable", "FactCell.category.uncategorized")
    }
  }

  internal enum FactsList {
    /// Chuck Norris Facts
    internal static let title = L10n.tr("Localizable", "FactsList.title")
    internal enum Alert {
      /// OK
      internal static let button = L10n.tr("Localizable", "FactsList.Alert.button")
      /// Chuck have burned all the facts, but Chuck can bring them back when you least expect it.
      internal static let message = L10n.tr("Localizable", "FactsList.Alert.message")
      /// We can't find any facts
      internal static let title = L10n.tr("Localizable", "FactsList.Alert.title")
    }
  }

  internal enum SearchFacts {
    internal enum Label {
      /// Find a random fact by category:
      internal static let header = L10n.tr("Localizable", "SearchFacts.Label.header")
    }
    internal enum SearchBar {
      /// Search for facts
      internal static let placeholder = L10n.tr("Localizable", "SearchFacts.SearchBar.placeholder")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
