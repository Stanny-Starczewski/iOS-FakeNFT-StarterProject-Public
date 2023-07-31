//
//  GetNftByIdRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct GetNftByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/nft/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
