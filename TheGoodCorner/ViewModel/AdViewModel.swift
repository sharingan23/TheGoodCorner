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
                
              /*  var filteredArrayAdByUrgent = unwrapAds
                
                filteredArrayAdByUrgent = filteredArrayAdByUrgent.filter { ($0.isUrgent)! }

                // Rearrange array by date
                self.adData = filteredArrayAdByUrgent.sorted(by: { $0.creationDate! > $1.creationDate!})*/
                
                self.adData = self.filteredArrayByUrgent(ad: unwrapAds) + self.filteredArrayWithOutUrgent(ad: unwrapAds)
            }
        }
    }
    
    func filteredArrayByUrgent(ad: [Ad]) -> [Ad] {
        var filteredArrayAdByUrgent = ad
        
        // Only urgent item
        filteredArrayAdByUrgent = filteredArrayAdByUrgent.filter { ($0.isUrgent)! }

        // Rearrange array by date
        filteredArrayAdByUrgent = filteredArrayAdByUrgent.sorted(by: { $0.creationDate! > $1.creationDate!})
        
        return filteredArrayAdByUrgent
    }
    
    func filteredArrayWithOutUrgent(ad: [Ad]) -> [Ad] {
        var filteredArrayAdByUrgent = ad
        
        // Only urgent item
        filteredArrayAdByUrgent = filteredArrayAdByUrgent.filter { ($0.isUrgent == false) }

        // Rearrange array by date
        filteredArrayAdByUrgent = filteredArrayAdByUrgent.sorted(by: { $0.creationDate! > $1.creationDate!})
        
        return filteredArrayAdByUrgent
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
    
    func filterBySearch(arrayAd: [Ad], searchedText: String) -> [Ad] {
        var filteredArrayAd = arrayAd
        
        filteredArrayAd = filteredArrayAd.filter { ($0.title?.lowercased().contains(searchedText))! }
        
        return filteredArrayAd
    }
}
