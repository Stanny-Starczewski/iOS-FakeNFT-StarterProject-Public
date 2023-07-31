// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum Localization {
  /// by
  public static let authorLabelText = Localization.tr("Localizable", "authorLabelText", fallback: "by")
  /// User Agreement
  public static let cartAgreementLinkLabelText = Localization.tr("Localizable", "cartAgreementLinkLabelText", fallback: "User Agreement")
  /// Cancel
  public static let cartBackButtonText = Localization.tr("Localizable", "cartBackButtonText", fallback: "Cancel")
  /// Are you sure you want to remove the object from the cart?
  public static let cartConfirmationText = Localization.tr("Localizable", "cartConfirmationText", fallback: "Are you sure you want to remove the object from the cart?")
  /// Delete
  public static let cartDeleteButtonText = Localization.tr("Localizable", "cartDeleteButtonText", fallback: "Delete")
  /// By making a purchase, you agree to the terms
  public static let cartDescriptionLabelText = Localization.tr("Localizable", "cartDescriptionLabelText", fallback: "By making a purchase, you agree to the terms")
  /// Cart is empty
  public static let cartEmptyCartLabelText = Localization.tr("Localizable", "cartEmptyCartLabelText", fallback: "Cart is empty")
  /// Your payment did not go through
  public static let cartErrorAlertMessageText = Localization.tr("Localizable", "cartErrorAlertMessageText", fallback: "Your payment did not go through")
  /// Try again
  public static let cartFailureButtonText = Localization.tr("Localizable", "cartFailureButtonText", fallback: "Try again")
  /// Oops! Something went wrong :( Try again!
  public static let cartFailureLabelText = Localization.tr("Localizable", "cartFailureLabelText", fallback: "Oops! Something went wrong :( Try again!")
  /// Pay
  public static let cartPaymentButtonText = Localization.tr("Localizable", "cartPaymentButtonText", fallback: "Pay")
  /// Back to catalog
  public static let cartSuccessButtonText = Localization.tr("Localizable", "cartSuccessButtonText", fallback: "Back to catalog")
  /// Success! Payment passed, congratulations on your purchase!
  public static let cartSuccessLabelText = Localization.tr("Localizable", "cartSuccessLabelText", fallback: "Success! Payment passed, congratulations on your purchase!")
  /// Choose a payment method
  public static let cartTitleLabelText = Localization.tr("Localizable", "cartTitleLabelText", fallback: "Choose a payment method")
  /// To pay
  public static let cartToPayButtonText = Localization.tr("Localizable", "cartToPayButtonText", fallback: "To pay")
  /// Developer
  public static let developerLabelText = Localization.tr("Localizable", "developerLabelText", fallback: "Developer")
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
