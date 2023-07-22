import Foundation

final class SetupManager {
    static let shared = SetupManager()
    
    private let userDefaults = UserDefaults.standard

    var sortCollectionsType: String? {
        get {
            return userDefaults.string(forKey: Keys.sortType.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.sortType.rawValue)
        }
    }
    
    private enum Keys: String {
        case sortType
    }
}

enum SortType: String {
    case sortByName
    case sortByCount

    static func getTypeByString(stringType: String) -> SortType {
        return SortType(rawValue: stringType) ?? .sortByName
    }
}
