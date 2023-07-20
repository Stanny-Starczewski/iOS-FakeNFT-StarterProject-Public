import Foundation

struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/collections")
    }
}

struct GetCollectionByIdRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/collections/\(id)")
    }
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
}
