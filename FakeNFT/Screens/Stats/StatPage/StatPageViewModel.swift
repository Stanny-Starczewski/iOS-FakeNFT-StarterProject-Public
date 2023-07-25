import Foundation

final class StatPageViewModel {
    private let model: StatPageModel

    var onChange: (() -> Void)?
    var onError: ((_ error: Error, _ retryAction: @escaping () -> Void) -> Void)?
    
    private(set) var users: [User] = [] {
        didSet {
            onChange?()
        }
    }

    var sortType: SortType? {
        didSet {
            saveSortType()
            sortUsers()
            onChange?()
        }
    }

    init(model: StatPageModel) {
        self.model = model
        loadSortType()
    }

    func saveSortType() {
        guard let sortType = sortType else {
            UserDefaults.standard.removeObject(forKey: Config.usersSortTypeKey)
            return
        }
        UserDefaults.standard.set(sortType.rawValue, forKey: Config.usersSortTypeKey)
    }

    func loadSortType() {
        if let sortTypeRawValue = UserDefaults.standard.string(forKey: Config.usersSortTypeKey),
           let savedSortType = SortType(rawValue: sortTypeRawValue) {
            sortType = savedSortType
        }
    }

    func getUsers(showLoader: @escaping (_ active: Bool) -> Void) {
        showLoader(true)

        model.getUsers { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    self.sortUsers()
                case .failure(let error):
                    self.onError?(error) { [weak self] in
                        self?.getUsers(showLoader: showLoader)
                    }
                    self.users = []
                }
                showLoader(false)
            }
        }
    }

    private func getSorted(users: [User], by sortType: SortType) -> [User] {
        switch sortType {
        case .byName:
            return users.sorted { $0.name < $1.name }
        case .byRating:
            return users.sorted { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
            
        }
    }

    func setSortedByName() {
        UserDefaults.standard.set(SortType.byName.rawValue, forKey: "usersSortType")
        sortType = .byName
    }

    func setSortedByRating() {
        UserDefaults.standard.set(SortType.byRating.rawValue, forKey: "usersSortType")
        sortType = .byRating
    }

    private func sortUsers() {
        guard let sortType = sortType else {
            return
        }
        users = getSorted(users: users, by: sortType)
    }
}

