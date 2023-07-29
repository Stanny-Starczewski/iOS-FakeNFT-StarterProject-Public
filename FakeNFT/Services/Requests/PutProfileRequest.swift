//
//  PutProfileRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 25.07.2023.
//

import Foundation

struct PutProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable?
    
    init(dto: Encodable) {
        self.dto = dto
    }
}
