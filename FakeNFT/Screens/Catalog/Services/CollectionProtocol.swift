import Foundation

protocol CollectionDataProviderProtocol {
    func getOrder(completion: @escaping (ResultModel<OrderModel>) -> Void)
    func updateOrder(with nftIds: [String], completion: @escaping (Result<Void, Error>) -> Void)
    func getNFT(by id: String, completion: @escaping (ResultModel<NFTModel>) -> Void)
    func getAuthor(by id: String, completion: @escaping (ResultModel<AuthorModel>) -> Void)
    func getFavorites(completion: @escaping (ResultModel<FavoritesModel>) -> Void)
    func updateFavorites(with favoritesIDs: [String], completion: @escaping (Result<Void, Error>) -> Void)
}
