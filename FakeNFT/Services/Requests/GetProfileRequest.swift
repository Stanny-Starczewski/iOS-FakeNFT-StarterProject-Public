//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 08.07.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
}
