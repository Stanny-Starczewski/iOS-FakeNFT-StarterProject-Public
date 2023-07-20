import Foundation

final class CatalogueViewModel {
    
    // MARK: - Properties

    @Observable private(set) var collections: [NFTCollection] = []
    private let provider: CatalogueProviderProtocol
    private let setupManager = SetupManager.shared

    private var sort: SortType? {
        didSet {
            guard let sort = sort else { return }
            applySort(by: sort)
            setupManager.sortCollectionsType = sort.rawValue
        }
    }
    
    // MARK: - Life Cycle
    
    init(provider: CatalogueProviderProtocol) {
        self.provider = provider
    }
    
    // MARK: - Functions
    
    private func setFilterByCount() {
        collections = collections.sorted(by: { $0.nfts.count < $1.nfts.count })
    }
    
    private func setFilterByName() {
        collections = collections.sorted(by: { $0.name < $1.name })
    }
    
    func setSortType(sortType: SortType) {
        self.sort = sortType
    }
    
    private func applySort(by value: SortType) {
        switch value {
        case .sortByCount:
            setFilterByCount()
        case .sortByName:
            setFilterByName()
        }
    }
    
    func getCollections() {
        provider.getCollections { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let collections):
                    self.collections = collections
                    
                    if let sortType = self.setupManager.sortCollectionsType {
                        self.setSortType(sortType: SortType.getTypeByString(stringType: sortType))
                    }
                case .failure(let error):
                    self.collections = []
                    print(error.localizedDescription)
                }
            }
        }
    }
}
