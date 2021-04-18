//
//  AdCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import UIKit

class AdCell: UICollectionViewCell {
    //MARK: Variables
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    var priceLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let ImageViewItem: UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .clear
        theImageView.contentMode = .scaleToFill
        theImageView.image = UIImage(named: Constants.ImageString.noPhoto)
        return theImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundAdCellColor
        self.layer.cornerRadius = 20
        setupImageItemView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup View
    
    func setupImageItemView() {
        self.addSubview(ImageViewItem)
        
        setupTitleLabl()
        imageViewItemConstraints()
        setupPriceLabel()
    }
    
    func imageViewItemConstraints() {
        ImageViewItem.translatesAutoresizingMaskIntoConstraints = false
        //ImageViewItem.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        //ImageViewItem.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        ImageViewItem.bottomAnchor.constraint(equalTo:   self.contentView.bottomAnchor, constant: -80).isActive = true
        ImageViewItem.topAnchor.constraint(equalTo:   self.contentView.topAnchor, constant: 40).isActive = true
        ImageViewItem.leftAnchor.constraint(equalTo:   self.contentView.leftAnchor, constant: 10).isActive = true
        ImageViewItem.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    func setupTitleLabl(){
        self.addSubview(self.titleLabel)
        
        titleLabelConstraints()
    }
    
    func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo:   ImageViewItem.bottomAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -20).isActive = true
    }
    
    func setupPriceLabel() {
        self.addSubview(self.priceLabel)
        
        priceLabelConstraints()
    }
    
    func priceLabelConstraints() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        //titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        priceLabel.topAnchor.constraint(equalTo:   titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -20).isActive = true
    }
 
}
