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
