//
//  GetAuthorByIdRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 26.07.2023.
//

import Foundation

struct GetAuthorByIdRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/users/\(id)") }
    
    init(id: String) {
        self.id = id
    }
}
