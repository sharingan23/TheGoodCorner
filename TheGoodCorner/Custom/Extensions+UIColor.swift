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
