//
//  ImageDownloaderService.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 18/04/2021.
//

import Foundation

class ImageDownloaderService : NSObject {
    private var imageSession = URLSession(configuration: .default)
    
        init(imageSession: URLSession) {
            self.imageSession = imageSession
        }
        
    func imageLoader(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            let request = createImageRequest(url: url)
            
            let task = imageSession.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        
                        completionHandler( nil, error)
                        
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        
                        completionHandler( nil, error)
                        
                        return
                    }
                    
                    completionHandler(data, nil)
                }
            }
            task.resume()
        }
        
        func createImageRequest(url: URL) -> URLRequest {
            let request = URLRequest(url: url)
            
            return request
        }
}
