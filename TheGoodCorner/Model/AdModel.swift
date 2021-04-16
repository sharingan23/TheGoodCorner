//
//  AdModel.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import Foundation

// MARK: - Ad Model

struct Ad: Codable {
    let id, categoryID: Int?
    let title, description: String?
    let price: Int?
    let imagesURL: ImagesURL?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
    
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
                    self.siret = try values.decode(String?.self, forKey: .siret)
                } catch {
                    self.siret = nil
                }
        do {
                    self.id = try values.decode(Int?.self, forKey: .id)
                } catch {
                    self.id = nil
                }
        do {
                    self.categoryID = try values.decode(Int?.self, forKey: .categoryID)
                } catch {
                    self.categoryID = nil
                }
        do {
                    self.title = try values.decode(String?.self, forKey: .title)
                } catch {
                    self.title = nil
                }
        do {
                    self.description = try values.decode(String?.self, forKey: .description)
                } catch {
                    self.description = nil
                }
        do {
                    self.price = try values.decode(Int?.self, forKey: .price)
                } catch {
                    self.price = nil
                }
        
        do {
                    self.imagesURL = try values.decode(ImagesURL?.self, forKey: .imagesURL)
                } catch {
                    self.imagesURL = nil
                }
        
        do {
                    self.creationDate = try values.decode(String?.self, forKey: .creationDate)
                } catch {
                    self.creationDate = nil
                }
        
        do {
                    self.isUrgent = try values.decode(Bool?.self, forKey: .isUrgent)
                } catch {
                    self.isUrgent = nil
                }
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
