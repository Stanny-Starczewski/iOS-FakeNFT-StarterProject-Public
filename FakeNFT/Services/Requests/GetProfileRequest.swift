//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(Config.baseUrl)/profile/1")
    }
}
