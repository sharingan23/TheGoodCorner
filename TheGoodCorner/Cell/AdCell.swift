//
//  AdCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import UIKit

class AdCell: UICollectionViewCell {
    var titleLabel:UILabel = {
               let label = UILabel(frame: CGRect(x:100, y: 30, width: UIScreen.main.bounds.width , height: 40))
               label.textAlignment = .left
                label.textColor = UIColor.black
               label.lineBreakMode = .byWordWrapping
               label.numberOfLines = 0
               return label
           }()

           override init(frame: CGRect) {
               super.init(frame: frame)
               self.addSubview(self.titleLabel)
           }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
