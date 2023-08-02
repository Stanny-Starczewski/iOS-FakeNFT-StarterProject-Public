//
//  GetCollectionByIdRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct GetCollectionByIdRequest: NetworkRequest {
    private let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/collections/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
