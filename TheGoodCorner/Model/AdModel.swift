//
//  AdModel.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import Foundation

// MARK: - Ad Model
struct Ad: Codable {
    let id, categoryID: Int
    let title, welcomeDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: Date
    let isUrgent: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case welcomeDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}

// MARK: - ImagesURL Model
struct ImagesURL: Codable {
    let small, thumb: String
}

// MARK: - Category Model
struct Category: Codable {
    let id: Int
    let name: String
}
