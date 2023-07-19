//
//  CartRequests.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 16.07.2023.
//

import Foundation

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

struct NftByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/nft/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
