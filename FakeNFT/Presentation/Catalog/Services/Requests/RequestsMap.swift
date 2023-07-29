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

struct GetNFTByIdRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + ("/nft/\(id)"))
    }
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
}

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + ("/orders/1"))
    }
}

struct GetUserByIdRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/users/\(id)")
    }
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
}

struct PutOrderRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/orders/1")
    }
    
    var httpMethod: HttpMethod = .put
    
    var body: Data? {
        try? JSONEncoder().encode(Body(nfts: nftIds))
    }
    
    private struct Body: Codable {
        let nfts: [String]
    }
    
    private let nftIds: [String]
    
    init(nftIds: [String]) {
        self.nftIds = nftIds
    }
}

struct GetFavoritesRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/profile/1")
    }
}

struct PutFavoritesRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: Config.baseUrl + "/profile/1")
    }
    
    var httpMethod: HttpMethod = .put
    
    var body: Data? {
        try? JSONEncoder().encode(Body(likes: likes))
    }
    
    private struct Body: Codable {
        let likes: [String]
    }
    
    private let likes: [String]
    
    init(likes: [String]) {
        self.likes = likes
    }
}
