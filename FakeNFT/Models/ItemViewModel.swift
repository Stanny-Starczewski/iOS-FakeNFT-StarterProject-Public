//
//  NFTViewModel.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 01.08.2023.
//

import Foundation

struct ItemViewModel {
    let id: String
    let name: String
    let imageURL: URL
    let rating: Int
    let price: Double
    let isOrdered: Bool
    let isLiked: Bool
}
