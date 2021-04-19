//
//  Extensions+UIColor.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import UIKit

extension UIColor {
    static func rgb(redCG: CGFloat, greenCG: CGFloat, blueCG: CGFloat) -> UIColor {
        
        return UIColor(red: redCG/255, green: greenCG/255, blue: blueCG/255, alpha: 1)
    }
    
    static let backgroundViewColor = UIColor.rgb(redCG: 167, greenCG: 189, blueCG: 217)
    static let backgroundAdCellColor = UIColor.rgb(redCG: 255, greenCG: 255, blueCG: 255)
    static let selectedCategoryBackgroundLblColor = UIColor.white
    static let unSelectedCategoryBackgroundLblColor = UIColor.rgb(redCG: 128, greenCG: 85, blueCG: 91)
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension Date {
   func getFormattedDate(format: String) -> String {
    
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
    
        return dateformat.string(from: self)
    }
}

extension String {
    func toDate()-> Date? {
        let isoDate = self
        
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)
        
        return date
    }
}
