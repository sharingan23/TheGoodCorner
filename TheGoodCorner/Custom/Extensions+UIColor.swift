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
    static let detailTextColor =  UIColor.rgb(redCG: 64, greenCG: 42, blueCG: 45)
    
    static func setGradientBackgroundColorView(view: UIView) {
        let colorTop =  UIColor(red: 254/255.0, green: 95/255.0, blue: 117/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 252/255.0, green: 152/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    class var separatorColor: UIColor {
      return UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
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
        dateformat.locale     = Locale(identifier: Constants.dateFormat.frenchFormat)
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

extension UIApplication {
    /// Checks if view hierarchy of application contains `UIRemoteKeyboardWindow` if it does, keyboard is presented
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}
