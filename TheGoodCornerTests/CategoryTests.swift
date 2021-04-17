//
//  CategoryTests.swift
//  TheGoodCornerTests
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import XCTest
@testable import TheGoodCorner

class CategoryTests: XCTestCase {
    func testGetCategoryShouldPostFailedCallbackIfError() {
            // Given
        
        let categoryService = CategoryAPIService(categorySession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataCategory.error))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            categoryService.apiToGetCategory { (category, error) in
                
                // Then
                XCTAssertNil(category)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetCategoryShouldPostFailedCallbackIfNoData() {
            // Given
        let categoryService = CategoryAPIService(categorySession: URLSessionFake(data: nil, response: nil, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
        
            categoryService.apiToGetCategory { (category, error) in
                // Then
                XCTAssertNil(category)
                XCTAssertNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetCategoryShouldPostFailedCallbackIfIncorrectResponse() {
            // Given
        let categoryService = CategoryAPIService(categorySession: URLSessionFake(data: FakeResponseDataCategory.categoryCorrectData, response: FakeResponseDataCategory.responseKO, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            categoryService.apiToGetCategory { (ads, error) in
                // Then
                XCTAssertNil(error)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetCategoryShouldPostFailedCallbackIfIncorrectData() {
            // Given
        let categoryService = CategoryAPIService(categorySession: URLSessionFake(data: FakeResponseDataCategory.categoryIncorrectData, response: FakeResponseDataCategory.responseOK, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            categoryService.apiToGetCategory { (category, error) in
                // Then
                XCTAssertNotNil(error)
                let firstCategory = "Véhicule"
                
                XCTAssertNotEqual(firstCategory, category?[0].name)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetCategoryShouldSuccessCallbackIfcorrectData() {
            // Given
        let categoryService = CategoryAPIService(categorySession: URLSessionFake(data: FakeResponseDataCategory.categoryCorrectData, response: FakeResponseDataCategory.responseOK, error: nil))
            
            
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            categoryService.apiToGetCategory { (category, error) in
                // Then
                XCTAssertNil(error)
                let firstCategory = "Véhicule"
                
                XCTAssertEqual(firstCategory, category?[0].name)
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1)
        }
}
