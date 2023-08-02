import Foundation

final class CollectionViewModel {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
        case failed
    }
    
    // MARK: - Properties
    
    var numberOfItems: Int {
        nftItems.count
    }
    
    let collectionModel: Collection
    
    @Observable private(set) var nftItems: [ItemViewModel] = []
    @Observable private(set) var authorModel: Author = Author(id: "", name: "", website: "")
    @Observable private(set) var loadingInProgress: Bool = false
    @Observable private(set) var mainLoadErrorDescription: String = ""
    @Observable private(set) var addToCartErrorDescription: String = ""
    @Observable private(set) var addToFavoritesErrorDescription: String = ""
    @Observable private(set) var loadingState: LoadingState = .idle
    
    private var orderItems: [String] = []
    private var likedItems: [String] = []
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initialization
    
    init(collectionModel: Collection, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.collectionModel = collectionModel
    }
    
    // MARK: - Functions
    
    func loadNFTForCollection(completion: @escaping () -> Void) {
            loadingInProgress = true
            loadingState = .loading
            let group = DispatchGroup()
            group.enter()
            networkService.getOrder { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let orderModel):
                    DispatchQueue.main.async {
                        self.orderItems = orderModel.nfts
                        group.leave()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.mainLoadErrorDescription = error.localizedDescription
                        group.leave()
                    }
                }
            }
            
            group.enter()
            networkService.getFavorites { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let favoritesModel):
                    DispatchQueue.main.async {
                        self.likedItems = favoritesModel.likes
                        group.leave()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.mainLoadErrorDescription = error.localizedDescription
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) { [weak self] in
                self?.loadNFTs(completion: completion)
            }
        }
        
        private func loadNFTs(completion: @escaping () -> Void) {
            let group = DispatchGroup()
            collectionModel.nfts.forEach { id in
                group.enter()
                networkService.getNft(by: id) { [weak self] result in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let nftModel):
                            DispatchQueue.main.async {
                                if let nftViewModel = self.convertToViewModel(from: nftModel) {
                                    self.nftItems.append(nftViewModel)
                                    group.leave()
                                }
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.loadingInProgress = false
                                self.mainLoadErrorDescription = error.localizedDescription
                                group.leave()
                            }
                        }
                    }
                }
            }
            group.notify(queue: .main) { [weak self] in
                self?.loadingInProgress = false
                self?.loadingState = .loaded
                completion()
            }
        }
    
    private func convertToViewModel(from item: Item) -> ItemViewModel? {
        guard let image = item.images.first,
              let imageURL = URL(string: image) else { return nil }
        
        let isNFTordered = orderItems.contains(item.id)
        let isNFTLiked = likedItems.contains(item.id)
                
        return ItemViewModel(id: item.id,
                            name: item.name,
                            imageURL: imageURL,
                            rating: item.rating,
                            price: item.price,
                            isOrdered: isNFTordered,
                            isLiked: isNFTLiked)
    }
    
    private func replaceNFT(nft: ItemViewModel, isLiked: Bool, isOrdered: Bool) {
        guard let itemIndex = nftItems.firstIndex(where: { $0.id == nft.id }) else { return }
        nftItems[itemIndex] = ItemViewModel(id: nft.id,
                                           name: nft.name,
                                           imageURL: nft.imageURL,
                                           rating: nft.rating,
                                           price: nft.price,
                                           isOrdered: isOrdered,
                                           isLiked: isLiked)
        loadingState = .loading
    }
    
    func getAuthorURL() {
        networkService.getAuthor(by: collectionModel.author) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let authorModel):
                    DispatchQueue.main.async {
                        self.authorModel = authorModel
                    }
                case .failure(let error):
                    self.mainLoadErrorDescription = error.localizedDescription
                }
            }
        }
    }
    
    func onAddToCart(indexPath: IndexPath) {
        let orderItemsBeforeAdding = orderItems
        
        let nftItem = nftItems[indexPath.row]
        if nftItem.isOrdered {
            guard let itemIndex = orderItems.firstIndex(of: nftItem.id) else { return }
            orderItems.remove(at: itemIndex)
        } else {
            orderItems.append(nftItem.id)
        }
        
        loadingInProgress = true
        let order = Order(nfts: orderItems)
        networkService.updateCart(nftsInCart: order) { [weak self] error in
            guard let self else { return }
            if let error {
                self.orderItems = orderItemsBeforeAdding
                self.loadingState = .failed
                self.loadingInProgress = false
                self.addToCartErrorDescription = error.localizedDescription
            } else {
                self.replaceNFT(nft: nftItem, isLiked: nftItem.isLiked, isOrdered: !nftItem.isOrdered)
                self.loadingInProgress = false
                self.loadingState = .loaded
            }
        }
    }
    
    func onAddToFavorites(indexPath: IndexPath) {
        let favoritesBeforeAdding = likedItems
        
        let nftItem = nftItems[indexPath.row]
        if nftItem.isLiked {
            guard let itemIndex = likedItems.firstIndex(of: nftItem.id) else { return }
            likedItems.remove(at: itemIndex)
        } else {
            likedItems.append(nftItem.id)
        }
        
        loadingInProgress = true
        let favorites = Favorites(likes: likedItems)
        networkService.updateFavorites(favorites: favorites) { [weak self] error in
            guard let self else { return }
            if let error {
                self.likedItems = favoritesBeforeAdding
                self.loadingInProgress = false
                self.addToFavoritesErrorDescription = error.localizedDescription
            } else {
                self.replaceNFT(nft: nftItem, isLiked: !nftItem.isLiked, isOrdered: nftItem.isOrdered)
                self.loadingInProgress = false
            }
        }
    }
}
