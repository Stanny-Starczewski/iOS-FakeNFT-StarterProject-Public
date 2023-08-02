//
//  GetCollectionsRequest.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? { URL(string: "\(Config.baseUrl)/collections") }
}
