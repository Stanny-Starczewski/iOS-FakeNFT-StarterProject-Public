import Foundation

struct ExampleRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64a03f83ed3c41bdd7a72309.mockapi.io/api/v1/")
    }
}
