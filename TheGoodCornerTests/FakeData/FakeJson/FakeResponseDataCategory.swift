//
//  FakeResponseDataCategory.swift
//  TheGoodCornerTests
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import Foundation

class FakeResponseDataCategory {
    // MARK: - Data
    static var categoryCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseDataCategory.self)
        let url = bundle.url(forResource: "Category", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let categoryIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://thegoodcorner.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://thegoodcorner.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class CategoryError: Error {}
    static let error = CategoryError()
}
