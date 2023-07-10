import Foundation

final class SetupManager {
    static let shared = SetupManager()
    
    let userDefaults = UserDefaults.standard

    var sortCollectionsType: String? {
        get {
            userDefaults.string(forKey: Keys.sortType.rawValue)
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
        switch stringType {
        case "sortByName":
            return SortType.sortByName
        case "sortByCount":
            return SortType.sortByCount
        default:
            return SortType.sortByName
        }
    }
}
