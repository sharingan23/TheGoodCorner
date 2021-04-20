//
//  Constants.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import Foundation

struct Constants {
    struct CellID {
        static let adCellID = "adCellID"
        static let categoryCellID = "categoryCellID"
        static let detailImageCellID = "detailImageCellID"
        static let detailCellID = "detaileCellID"
        static let descriptionCellID = "descriptionCellID"
    }
    
    struct ImageString {
        static let noPhoto = "nophoto"
        static let noItem = "box"
        static let urgent = "urgentStar"
    }
    
    struct ErrorString {
        static let oopsMsg = "Oopps..!"
        static let noAdMsg = "Nous n'avons pas d'annonces sous la main."
        static let alertTitle = "TheGoodCorner"
        static let alertNoInternetMsg = "vous n'êtes pas connecté a internet."
        static let okAction = "OK"
    }
    
    struct itemString {
        static let currecy = " €"
        static let noValue = ""
        static let allFilter = "Tous"
    }
    
    struct textString {
        static let searchPlaceholder = "Que recherchez-vous ?"
        static let appName = "TheGoodCorner"
    }
}
