import Foundation

typealias CollectionsCompletionHandler = (Result<[NFTCollection], Error>) -> Void

final class CatalogueDataProvider: CatalogueProviderProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - CatalogueProviderProtocol
    
    func getCollections(completion: @escaping CollectionsCompletionHandler) {
        let getCollectionsRequest = GetCollectionsRequest()
        networkClient.send(
            request: getCollectionsRequest,
            type: [NFTCollection].self
        ) { result in
            self.handleCollectionsResult(result, completion: completion)
        }
    }
    
    // MARK: - Private
    
    private func handleCollectionsResult(_ result: Result<[NFTCollection], Error>, completion: @escaping CollectionsCompletionHandler) {
        switch result {
        case .success(let collections):
            completion(.success(collections))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
