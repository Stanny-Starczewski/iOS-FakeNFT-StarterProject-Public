//
//  CartRequests.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 16.07.2023.
//

import Foundation

// MARK: - Cart Requests

struct GetOrdersRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1") }
}

struct ChangeOrdersRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1") }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable?
    
    init(dto: Encodable) {
        self.dto = dto
    }
}

struct GetNftByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/nft/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}

struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/currencies") }
}

struct PaymentWithIdCurrencyRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1/payment/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}

struct GetAuthorByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/users/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
}

struct PutProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable?
    
    init(dto: Encodable) {
        self.dto = dto
    }
}
