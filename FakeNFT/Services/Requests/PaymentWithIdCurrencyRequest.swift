//
//  PaymentWithIdCurrencyRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct PaymentWithIdCurrencyRequest: NetworkRequest {
    private let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/orders/1/payment/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
