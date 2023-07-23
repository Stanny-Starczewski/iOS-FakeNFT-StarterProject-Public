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
    
    let collectionModel: NFTCollection
    
    @Observable private(set) var nftItems: [NFTViewModel] = []
    @Observable private(set) var authorModel: AuthorModel = AuthorModel(id: "", name: "", website: "")
    @Observable private(set) var loadingInProgress: Bool = false
    @Observable private(set) var mainLoadErrorDescription: String = ""
    @Observable private(set) var addToCartErrorDescription: String = ""
    @Observable private(set) var addToFavoritesErrorDescription: String = ""
    @Observable private(set) var loadingState: LoadingState = .idle
    
    private var orderItems: [String] = []
    private var likedItems: [String] = []
    
    private let collectionDataProvider: CollectionDataProviderProtocol
    
    // MARK: - Initialization

    init(collectionModel: NFTCollection, collectionDataProvider: CollectionDataProviderProtocol = CollectionDataProvider()) {
        self.collectionDataProvider = collectionDataProvider
        self.collectionModel = collectionModel
    }
    
    // MARK: - Functions

    func loadNFTForCollection() {
        loadingInProgress = true
        loadingState = .loading
        
        collectionDataProvider.getOrder { [weak self] result in
            guard let self else { return }
                switch result {
                case .success(let orderModel):
                    DispatchQueue.main.async {
                        self.orderItems = orderModel.nfts
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.mainLoadErrorDescription = error.localizedDescription
                    }
                }
        }

        collectionDataProvider.getFavorites { [weak self] result in
            guard let self else { return }
                switch result {
                case .success(let favoritesModel):
                    DispatchQueue.main.async {
                        self.likedItems = favoritesModel.likes
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.mainLoadErrorDescription = error.localizedDescription
                    }
                }
        }
        
        let group = DispatchGroup()
        collectionModel.nfts.forEach { id in
            group.enter()
            collectionDataProvider.getNFT(by: id, completion: { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let nftModel):
                        DispatchQueue.main.async {
                            if let nftViewModel = self.convertToViewModel(from: nftModel) {
                                self.nftItems.append(nftViewModel)
                                group.leave()
                                print("Left group for id: \(id)")
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.loadingInProgress = false
                            self.mainLoadErrorDescription = error.localizedDescription
                            group.leave()
                            print("Left group for id: \(id)")
                            print("Error fetching NFT for id \(id):", error.localizedDescription)
                        }
                    }
                }
            })
        }
        group.notify(queue: .main) { [weak self] in
            self?.loadingInProgress = false
            self?.loadingState = .loaded
        }
    }
    
    private func convertToViewModel(from nftModel: NFTModel) -> NFTViewModel? {
        print("Получена модель: \(nftModel)")
        guard let image = nftModel.images.first,
              let imageURL = URL(string: image) else { print("Не найдено изображение в модели"); return nil }
        
        let isNFTordered = orderItems.contains(nftModel.id)
        let isNFTLiked = likedItems.contains(nftModel.id)
        
        let viewModel = NFTViewModel(id: nftModel.id,
                                     name: nftModel.name,
                                     imageURL: imageURL,
                                     rating: nftModel.rating,
                                     price: nftModel.price,
                                     isOrdered: isNFTordered,
                                     isLiked: isNFTLiked)

          print("Создана view модель: \(viewModel)")
        
        return NFTViewModel(id: nftModel.id,
                            name: nftModel.name,
                            imageURL: imageURL,
                            rating: nftModel.rating,
                            price: nftModel.price,
                            isOrdered: isNFTordered,
                            isLiked: isNFTLiked)
    }
    
    private func replaceNFT(nft: NFTViewModel, isLiked: Bool, isOrdered: Bool) {
        guard let itemIndex = nftItems.firstIndex(where: { $0.id == nft.id }) else { return }
        nftItems[itemIndex] = NFTViewModel(id: nft.id,
                                           name: nft.name,
                                           imageURL: nft.imageURL,
                                           rating: nft.rating,
                                           price: nft.price,
                                           isOrdered: isOrdered,
                                           isLiked: isLiked)
        loadingState = .loading
    }
    
    func getAuthorURL() {
        collectionDataProvider.getAuthor(by: collectionModel.author) { [weak self] result in
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
        collectionDataProvider.updateOrder(with: orderItems) { [weak self] result in
            guard let self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.replaceNFT(nft: nftItem, isLiked: nftItem.isLiked, isOrdered: !nftItem.isOrdered)
                        self.loadingInProgress = false
                        self.loadingState = .loaded
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.orderItems = orderItemsBeforeAdding
                        self.loadingState = .failed
                        self.loadingInProgress = false
                        self.addToCartErrorDescription = error.localizedDescription
                    }
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
        collectionDataProvider.updateFavorites(with: likedItems) { [weak self] result in
            guard let self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.replaceNFT(nft: nftItem, isLiked: !nftItem.isLiked, isOrdered: nftItem.isOrdered)
                        self.loadingInProgress = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.likedItems = favoritesBeforeAdding
                        self.loadingInProgress = false
                        self.addToFavoritesErrorDescription = error.localizedDescription
                    }
                }
            }
    }
}
