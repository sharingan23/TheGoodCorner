//
//  AdAPIService.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import Foundation

class AdAPIService: NSObject {
    private let adSourcesURL = URL(string: "h​ttps://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
    
    func apiToGetAd(completion : @escaping (Ad) -> ()) {
        URLSession.shared.dataTask(with: adSourcesURL) {data, URLResponse, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                let adData = try! jsonDecoder.decode(Ad.self, from: data)
                
                completion(adData)
            }
        } .resume()
    }
}
