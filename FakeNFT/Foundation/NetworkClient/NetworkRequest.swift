import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
}

// default values
extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var queryParameters: [String: String]? { nil }
    var body: Data? { nil }
}
