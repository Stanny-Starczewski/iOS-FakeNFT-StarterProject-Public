import Foundation

enum ResultModel<T> {
    case success(T)
    case failure(Error)
}

final class CollectionDataProvider: CollectionDataProviderProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getOrder(completion: @escaping (ResultModel<OrderModel>) -> Void) {
        let getOrderRequest = GetOrderRequest()
        networkClient.send(request: getOrderRequest, type: OrderModel.self) { result in
            self.handleResult(result, completion: completion)
        }
    }
    
    func updateOrder(with nftIds: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let putOrderRequest = PutOrderRequest(nftIds: nftIds)
        networkClient.send(request: putOrderRequest, type: OrderModel.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNFT(by id: String, completion: @escaping (ResultModel<NFTModel>) -> Void) {
        let getNFTByIdRequest = GetNFTByIdRequest(id: id)
        networkClient.send(request: getNFTByIdRequest, type: NFTModel.self) { result in
            self.handleResult(result, completion: completion)
        }
    }
    
    func getAuthor(by id: String, completion: @escaping (ResultModel<AuthorModel>) -> Void) {
        let getUserByIdRequest = GetUserByIdRequest(id: id)
        networkClient.send(request: getUserByIdRequest, type: AuthorModel.self) { result in
            self.handleResult(result, completion: completion)
        }
    }
    
    func getFavorites(completion: @escaping (ResultModel<FavoritesModel>) -> Void) {
        let getFavoritesRequest = GetFavoritesRequest()
        networkClient.send(request: getFavoritesRequest, type: FavoritesModel.self) { result in
            self.handleResult(result, completion: completion)
        }
    }
    
    func updateFavorites(with favoritesIDs: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let putFavoritesRequest = PutFavoritesRequest(likes: favoritesIDs)
        networkClient.send(request: putFavoritesRequest, type: FavoritesModel.self) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (ResultModel<T>) -> Void) {
        switch result {
        case .success(let value):
            completion(.success(value))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
