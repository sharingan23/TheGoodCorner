//
//  TheGoodCornerTests.swift
//  TheGoodCornerTests
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import XCTest
@testable import TheGoodCorner

class TheGoodCornerTests: XCTestCase {

    func testGetAdShouldPostFailedCallbackIfError() {
            // Given
        
        let adService = AdAPIService(adSession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataAd.error))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            adService.apiToGetAd { (ads, error) in
                
                // Then
                XCTAssertNil(ads)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetAdShouldPostFailedCallbackIfNoData() {
            // Given
        let adService = AdAPIService(adSession: URLSessionFake(data: nil, response: nil, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
        
            adService.apiToGetAd { (ads, error) in
                // Then
                XCTAssertNil(ads)
                XCTAssertNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetAdShouldPostFailedCallbackIfIncorrectResponse() {
            // Given
        let adService = AdAPIService(adSession: URLSessionFake(data: FakeResponseDataAd.adCorrectData, response: FakeResponseDataAd.responseKO, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            adService.apiToGetAd { (ads, error) in
                // Then
                XCTAssertNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetAdShouldPostFailedCallbackIfIncorrectData() {
            // Given
        let adService = AdAPIService(adSession: URLSessionFake(data: FakeResponseDataAd.adIncorrectData, response: FakeResponseDataAd.responseOK, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            adService.apiToGetAd { (ads, error) in
                // Then
                XCTAssertNotNil(error)
                let firstAdPrice = 140.00
                
                XCTAssertNotEqual(firstAdPrice, ads?[0].price)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetAdShouldSuccessCallbackIfcorrectData() {
            // Given
        let adService = AdAPIService(adSession: URLSessionFake(data: FakeResponseDataAd.adCorrectData, response: FakeResponseDataAd.responseOK, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            adService.apiToGetAd { (ads, error) in
                // Then
                XCTAssertNil(error)
                let firstAdPrice = 140.00
                
                XCTAssertEqual(firstAdPrice, ads?[0].price)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
}
