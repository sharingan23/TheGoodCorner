//
//  CategoryAPIService.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import Foundation

class CategoryAPIService: NSObject {
    private let categorySourcesURL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    
    private var categorySession = URLSession(configuration: .default)
    
        init(categorySession: URLSession) {
            self.categorySession = categorySession
        }
        
        func apiToGetCategory(completionHandler: @escaping ([Category]?, Error?) -> Void) {
            let request = createCategoryRequest()
            
            let task = categorySession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        
                        completionHandler( nil, error)
                        
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        
                        completionHandler( nil, error)
                        
                        return
                    }
                    do {
                        
                        let responseJSON = try JSONDecoder().decode([Category].self, from: data)
                        
                        completionHandler(responseJSON, nil)
                        
                    } catch {
                        
                        completionHandler( nil, error)
                    }
                }
            }
            task.resume()
        }
        
        func createCategoryRequest() -> URLRequest {
            let request = URLRequest(url: categorySourcesURL)
            
            return request
        }
}
