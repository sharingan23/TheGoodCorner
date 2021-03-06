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
                self.categoryData = [Category(id: 0, name: Constants.itemString.allFilter)] + unwrapCategories
            }
        }
    }
    
    func getCategoryFromInt(id: Int) -> String? {
        if let unwrapCategoryData = categoryData {
            if let foundCategory = unwrapCategoryData.first(where: {$0.id == id}) {
                return foundCategory.name
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
