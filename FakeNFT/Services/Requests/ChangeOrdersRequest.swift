//
//  ChangeOrdersRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct ChangeOrdersRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1") }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable?
    
    init(dto: Encodable) {
        self.dto = dto
    }
}
