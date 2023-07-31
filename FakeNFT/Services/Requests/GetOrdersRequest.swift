//
//  GetOrdersRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct GetOrdersRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1") }
}
