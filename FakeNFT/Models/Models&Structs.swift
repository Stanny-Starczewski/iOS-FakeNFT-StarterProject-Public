import Foundation

enum StatSortType: String {
    case byName = "BYNAME"
    case byRating = "BYRATING"
}

struct Nft: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let id: String
}

struct User: Codable {
    let avatar: String
    let name: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}

struct Request: NetworkRequest {
    var endpoint: URL?
    var queryParameters: [String: String]?
    var httpMethod: HttpMethod
}

struct PaymentStatus: Codable {
    let success: Bool
    let id: String
    let orderId: String
}
struct Currency: Codable {
    let title: String
    let name: String
    let image: String
    let id: String
}

struct Profile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}

enum SortAttribute {
    case name
    case nftCount
}
