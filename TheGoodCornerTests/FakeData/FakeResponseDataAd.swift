//
//  FakeResponseDataAd.swift
//  TheGoodCornerTests
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import Foundation

class FakeResponseDataAd {
    // MARK: - Data
    static var adCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseDataAd.self)
        let url = bundle.url(forResource: "Ad", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let adIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://thegoodcorner.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://thegoodcorner.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class AdError: Error {}
    static let error = AdError()
}
