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
}
