//
//  HomeResponse.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//
import Foundation

// MARK: - HomeResponseElement
struct HomeResponseElement: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let category: [Category]
    let productPromo: [ProductPromo]
}

// MARK: - Category
struct Category: Codable {
    let imageURL: String
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
}

// MARK: - ProductPromo
struct ProductPromo: Codable {
    let id: String
    let imageURL: String
    let title, productPromoDescription, price: String
    var loved: Int

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
}

typealias HomeResponse = [HomeResponseElement]
