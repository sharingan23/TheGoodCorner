//
//  AdAPIService.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import Foundation

class AdAPIService: NSObject {
    private let adSourcesURL = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
    
    private var adSession = URLSession(configuration: .default)
    
        init(adSession: URLSession) {
            self.adSession = adSession
        }
        
        func apiToGetAd(completionHandler: @escaping ([Ad]?, Error?) -> Void) {
            let request = createAdRequest()
            
            let task = adSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription)
                        completionHandler( nil, error)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        print(error?.localizedDescription)
                        completionHandler( nil, error)
                        return
                    }
                    do {
                        let responseJSON = try JSONDecoder().decode([Ad].self, from: data)
                        print("succes")
                        completionHandler(responseJSON, nil)
                    } catch {
                        print(error.localizedDescription)
                        completionHandler( nil, error)
                    }
                }
            }
            task.resume()
        }
        
        func createAdRequest() -> URLRequest {
            let request = URLRequest(url: adSourcesURL)
            
            return request
        }
}
