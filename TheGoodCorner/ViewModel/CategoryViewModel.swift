//
//  CategoryViewModel.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import Foundation

class CategoryViewModel : NSObject {
    
    private var categoryApiService : CategoryAPIService!
    var categoryService = CategoryAPIService(categorySession: URLSession(configuration: .default))
    
    private(set) var categoryData : [Category]! {
        didSet {
            self.bindCategoryViewModelToController()
        }
    }
    
    var bindCategoryViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.categoryApiService =  categoryService
        callFuncToGetCategoryData()
    }
    
    func callFuncToGetCategoryData() {
        self.categoryApiService.apiToGetCategory { (categories, error) in
            if let unwrapCategories = categories {
                self.categoryData = unwrapCategories
            }
        }
    }
}
