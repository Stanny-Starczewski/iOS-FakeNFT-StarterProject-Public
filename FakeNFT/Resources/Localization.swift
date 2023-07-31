// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum Localization {
  /// by
  public static let authorLabelText = Localization.tr("Localizable", "authorLabelText", fallback: "by")
  /// Developer
  public static let developerLabelText = Localization.tr("Localizable", "developerLabelText", fallback: "Developer")
  /// Cart is empty
  public static let emptyCartLabelText = Localization.tr("Localizable", "emptyCartLabelText", fallback: "Cart is empty")
  /// You don't have NFT yet
  public static let emptyLabelText = Localization.tr("Localizable", "emptyLabelText", fallback: "You don't have NFT yet")
  /// Close
  public static let errorAlertCancelAction = Localization.tr("Localizable", "errorAlertCancelAction", fallback: "Close")
  /// OK
  public static let errorAlertOkAction = Localization.tr("Localizable", "errorAlertOkAction", fallback: "OK")
  /// Try again
  public static let errorAlertRepeatAction = Localization.tr("Localizable", "errorAlertRepeatAction", fallback: "Try again")
  /// Error!
  public static let errorAlertRepeatTitle = Localization.tr("Localizable", "errorAlertRepeatTitle", fallback: "Error!")
  /// Oops! We have a error.
  public static let errorAlertTitle = Localization.tr("Localizable", "errorAlertTitle", fallback: "Oops! We have a error.")
  /// Favorites NFT
  public static let favoritesNftLabelText = Localization.tr("Localizable", "favoritesNftLabelText", fallback: "Favorites NFT")
  /// My NFT
  public static let myNftLabelText = Localization.tr("Localizable", "myNftLabelText", fallback: "My NFT")
  /// My NFT
  public static let navigationBarTitleText = Localization.tr("Localizable", "navigationBarTitleText", fallback: "My NFT")
  /// No internet
  public static let noInternetLabelText = Localization.tr("Localizable", "noInternetLabelText", fallback: "No internet")
  /// To pay
  public static let paymentButtonText = Localization.tr("Localizable", "paymentButtonText", fallback: "To pay")
  /// Price
  public static let priceLabelText = Localization.tr("Localizable", "priceLabelText", fallback: "Price")
  /// By name
  public static let sortingAlertByFirstNameText = Localization.tr("Localizable", "sortingAlertByFirstNameText", fallback: "By name")
  /// By title
  public static let sortingAlertByNameText = Localization.tr("Localizable", "sortingAlertByNameText", fallback: "By title")
  /// By number of NFTs
  public static let sortingAlertByNumberOfNFTsText = Localization.tr("Localizable", "sortingAlertByNumberOfNFTsText", fallback: "By number of NFTs")
  /// By price
  public static let sortingAlertByPriceText = Localization.tr("Localizable", "sortingAlertByPriceText", fallback: "By price")
  /// By rating
  public static let sortingAlertByRatingText = Localization.tr("Localizable", "sortingAlertByRatingText", fallback: "By rating")
  /// Close
  public static let sortingAlertCloseText = Localization.tr("Localizable", "sortingAlertCloseText", fallback: "Close")
  /// Localizable.strings
  ///   FakeNFT
  /// 
  ///   Created by Anton Vikhlyaev on 29.07.2023.
  public static let sortingAlertTitle = Localization.tr("Localizable", "sortingAlertTitle", fallback: "Sorting")
  /// Cart
  public static let tabCartTitle = Localization.tr("Localizable", "tabCartTitle", fallback: "Cart")
  /// Catalog
  public static let tabCatalogTitle = Localization.tr("Localizable", "tabCatalogTitle", fallback: "Catalog")
  /// Profile
  public static let tabProfileTitle = Localization.tr("Localizable", "tabProfileTitle", fallback: "Profile")
  /// Stats
  public static let tabStatsTitle = Localization.tr("Localizable", "tabStatsTitle", fallback: "Stats")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
