//
//  PaymentStatus.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 31.07.2023.
//

import Foundation

struct PaymentStatus: Codable {
    let success: Bool
    let id: String
    let orderId: String
}
