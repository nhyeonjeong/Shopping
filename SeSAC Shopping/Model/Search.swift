//
//  Search.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/21.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, mallName, productId: String

}

//캠핑카
