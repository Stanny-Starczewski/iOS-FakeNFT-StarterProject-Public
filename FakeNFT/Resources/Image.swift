// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Image {
  public static let cartResultImageFailure = ImageAsset(name: "cart-result-image-failure")
  public static let cartResultImageSuccess = ImageAsset(name: "cart-result-image-success")
  public static let appBlack = ColorAsset(name: "appBlack")
  public static let appLightGrey = ColorAsset(name: "appLightGrey")
  public static let appWhite = ColorAsset(name: "appWhite")
  public static let customBackground = ColorAsset(name: "customBackground")
  public static let customBlack = ColorAsset(name: "customBlack")
  public static let customBlue = ColorAsset(name: "customBlue")
  public static let customGreen = ColorAsset(name: "customGreen")
  public static let customGrey = ColorAsset(name: "customGrey")
  public static let customRed = ColorAsset(name: "customRed")
  public static let customWhite = ColorAsset(name: "customWhite")
  public static let customYellow = ColorAsset(name: "customYellow")
  public static let iconAda = ImageAsset(name: "icon-ada")
  public static let iconApe = ImageAsset(name: "icon-ape")
  public static let iconBtc = ImageAsset(name: "icon-btc")
  public static let iconDoge = ImageAsset(name: "icon-doge")
  public static let iconEth = ImageAsset(name: "icon-eth")
  public static let iconShib = ImageAsset(name: "icon-shib")
  public static let iconSol = ImageAsset(name: "icon-sol")
  public static let iconUsdt = ImageAsset(name: "icon-usdt")
  public static let iconCartAdd = ImageAsset(name: "icon-cart-add")
  public static let iconCartDelete = ImageAsset(name: "icon-cart-delete")
  public static let iconHeartFilled = ImageAsset(name: "icon-heart-filled")
  public static let iconHeart = ImageAsset(name: "icon-heart")
  public static let iconStarFilled = ImageAsset(name: "icon-star-filled")
  public static let iconStar = ImageAsset(name: "icon-star")
  public static let iconStars0 = ImageAsset(name: "icon-stars-0")
  public static let iconStars1 = ImageAsset(name: "icon-stars-1")
  public static let iconStars2 = ImageAsset(name: "icon-stars-2")
  public static let iconStars3 = ImageAsset(name: "icon-stars-3")
  public static let iconStars4 = ImageAsset(name: "icon-stars-4")
  public static let iconStars5 = ImageAsset(name: "icon-stars-5")
  public static let iconCart = ImageAsset(name: "icon-cart")
  public static let iconCatalog = ImageAsset(name: "icon-catalog")
  public static let iconProfile = ImageAsset(name: "icon-profile")
  public static let iconStats = ImageAsset(name: "icon-stats")
  public static let iconBack = ImageAsset(name: "icon-back")
  public static let iconClose = ImageAsset(name: "icon-close")
  public static let iconEdit = ImageAsset(name: "icon-edit")
  public static let iconForward = ImageAsset(name: "icon-forward")
  public static let iconSort = ImageAsset(name: "icon-sort")
  public static let launchScreenBackgroundColor = ColorAsset(name: "LaunchScreen_BackgroundColor")
  public static let launchScreenLogo = ImageAsset(name: "LaunchScreen_Logo")
  public static let placeholderAvatar = ImageAsset(name: "placeholder-avatar")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name superfluous_disable_command file_length implicit_return

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif
// swiftlint:disable deployment_target
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
// swiftlint:enable convenience_type deployment_target
