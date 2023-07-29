import Foundation

final class CollectionDataProvider: CollectionDataProviderProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Helpers
    
    private func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    // MARK: - CollectionDataProviderProtocol
    
    func getOrder(completion: @escaping (Result<OrderModel, Error>) -> Void) {
        let getOrderRequest = GetOrderRequest()
        networkClient.send(request: getOrderRequest, type: OrderModel.self, onResponse: completion)
    }
    
    func updateOrder(with nftIds: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let putOrderRequest = PutOrderRequest(nftIds: nftIds)
        networkClient.send(request: putOrderRequest, type: OrderModel.self) { result in
            switch result {
            case .success:
                self.handleResult(.success(()), completion: completion)
            case .failure(let error):
                self.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
    func getNFT(by id: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let getNFTByIdRequest = GetNFTByIdRequest(id: id)
        networkClient.send(request: getNFTByIdRequest, type: NFTModel.self, onResponse: completion)
    }

    func getAuthor(by id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void) {
        let getUserByIdRequest = GetUserByIdRequest(id: id)
        networkClient.send(request: getUserByIdRequest, type: AuthorModel.self, onResponse: completion)
    }
    
    func getFavorites(completion: @escaping (Result<FavoritesModel, Error>) -> Void) {
        let getFavoritesRequest = GetFavoritesRequest()
        networkClient.send(request: getFavoritesRequest, type: FavoritesModel.self, onResponse: completion)
    }
    
    func updateFavorites(with favoritesIDs: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let putFavoritesRequest = PutFavoritesRequest(likes: favoritesIDs)
        networkClient.send(request: putFavoritesRequest, type: FavoritesModel.self) { result in
            switch result {
            case .success:
                self.handleResult(.success(()), completion: completion)
            case .failure(let error):
                self.handleResult(.failure(error), completion: completion)
            }
        }
    }
}
