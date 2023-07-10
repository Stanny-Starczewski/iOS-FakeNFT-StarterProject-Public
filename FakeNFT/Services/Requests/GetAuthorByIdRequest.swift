//
//  GetAuthorByIdRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 09.07.2023.
//

import Foundation

struct GetAuthorByIdRequest: NetworkRequest {
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var endpoint: URL? {
        URL(string: "https://64a03f83ed3c41bdd7a72309.mockapi.io/api/v1/users/\(id)")
    }
}
