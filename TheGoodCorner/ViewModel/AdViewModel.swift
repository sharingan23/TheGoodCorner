//
//  AdViewModel.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import Foundation

class AdViewModel : NSObject {
    
    private var adApiService : AdAPIService!
    var adService = AdAPIService(adSession: URLSession(configuration: .default))
    var imageDownloaderService = ImageDownloaderService(imageSession: URLSession(configuration: .default))
    
    private(set) var adData : [Ad]! {
        didSet {
            self.bindAdViewModelToController()
        }
    }
    
    var bindAdViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.adApiService =  adService
        callFuncToGetAdData()
    }
    
    func callFuncToGetAdData() {
        self.adApiService.apiToGetAd { (ad, error) in
            if let unwrapAds = ad {
                self.adData = unwrapAds
            }
        }
    }
    
    func callFuncToGetImageData(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        self.imageDownloaderService.imageLoader(url: url) { (data, error) in
            if let unwrapData = data {
                completionHandler(unwrapData,nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    func filterByCategory(arrayAd: [Ad], category: Category) -> [Ad] {
        var filteredArrayAd = arrayAd
        if category.id != 0 {
            filteredArrayAd = arrayAd.filter { $0.categoryID == category.id }
        }
        
        return filteredArrayAd
    }
}
