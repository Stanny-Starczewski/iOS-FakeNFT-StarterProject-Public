//
//  AuthorModel.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct Author: Decodable {
    let id: String
    let name: String
    let website: String
}
