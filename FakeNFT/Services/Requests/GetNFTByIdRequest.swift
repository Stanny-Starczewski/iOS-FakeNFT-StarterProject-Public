//
//  GetNFTByIdRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 09.07.2023.
//

import Foundation

struct GetNftByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/nft/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
