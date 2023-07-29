import Foundation

protocol CatalogueProviderProtocol {
    func getCollections(completion: @escaping (Result<[NFTCollection], Error>) -> Void)
}
