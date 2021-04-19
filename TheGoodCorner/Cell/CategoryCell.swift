//
//  CategoryCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 19/04/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    var categoryLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = self.frame.height / 2.0
        
        setupCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCategoryLabel(){
        self.addSubview(self.categoryLabel)
        
        categoryLabelConstraints()
    }
    
    func categoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -5).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 5).isActive = true
    }
}
