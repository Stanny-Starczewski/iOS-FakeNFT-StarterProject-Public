//
//  PutProfileRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 25.07.2023.
//

import Foundation

struct PutProfileRequest: NetworkRequest {
    struct Body: Encodable {
        let name: String
        let avatar: String
        let description: String
        let website: String
    }
    
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
    
    var httpMethod: HttpMethod = .put
    
    var body: Data?
    
    init(
        name: String,
        avatar: String,
        description: String,
        website: String
    ) {
        self.body = try? JSONEncoder().encode(Body(
            name: name,
            avatar: avatar,
            description: description,
            website: website
        ))
    }
}
