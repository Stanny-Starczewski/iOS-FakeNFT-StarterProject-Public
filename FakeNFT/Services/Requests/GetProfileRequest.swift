//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 08.07.2023.
//

import Foundation


struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://64a03f83ed3c41bdd7a72309.mockapi.io/api/v1/profile/1")
    }
}
