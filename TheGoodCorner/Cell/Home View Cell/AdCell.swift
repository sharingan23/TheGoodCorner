//
//  AdCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 17/04/2021.
//

import UIKit

class AdCell: UICollectionViewCell {
    //MARK: Label
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
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var categoryLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var dateLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: ImageView
    
    let ImageViewItem: UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .clear
        theImageView.contentMode = .scaleAspectFit
        theImageView.image = UIImage(named: Constants.ImageString.noPhoto)
        return theImageView
    }()
    
    let urgentImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .clear
        theImageView.contentMode = .scaleAspectFit
        theImageView.image = UIImage(named: Constants.ImageString.urgent)
        return theImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundAdCellColor
        self.layer.cornerRadius = 20
        
        setupImageItemView()
        setupTitleLabl()
        imageViewItemConstraints()
        
        setupPriceLabel()
        setupCategoryLabel()
        
        setupDateLabel()
        setupUrgentImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup ImageView
    
    func setupImageItemView() {
        self.addSubview(ImageViewItem)
        
        imageViewItemConstraints()
    }
    
    func imageViewItemConstraints() {
        ImageViewItem.translatesAutoresizingMaskIntoConstraints = false
        ImageViewItem.bottomAnchor.constraint(equalTo:   self.contentView.bottomAnchor, constant: -80).isActive = true
        ImageViewItem.topAnchor.constraint(equalTo:   self.contentView.topAnchor, constant: 40).isActive = true
        ImageViewItem.leftAnchor.constraint(equalTo:   self.contentView.leftAnchor, constant: 10).isActive = true
        ImageViewItem.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    func setupUrgentImage() {
        self.addSubview(self.urgentImageView)
        
        urgentImageConstraints()
    }
    
    //MARK: Setup Label
    
    func urgentImageConstraints() {
        urgentImageView.translatesAutoresizingMaskIntoConstraints = false
        urgentImageView.topAnchor.constraint(equalTo:   self.contentView.topAnchor, constant: 5).isActive = true
        urgentImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        urgentImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        urgentImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -10).isActive = true
    }
    
    func setupTitleLabl(){
        self.addSubview(self.titleLabel)
        
        titleLabelConstraints()
    }
    
    func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
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
        priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        priceLabel.topAnchor.constraint(equalTo:   titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -20).isActive = true
    }
    
    func setupCategoryLabel() {
        self.addSubview(self.categoryLabel)
        
        categoryLabelConstraints()
    }
    
    func categoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo:   titleLabel.bottomAnchor, constant: 5).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -20).isActive = true
    }
    
    func setupDateLabel() {
        self.addSubview(self.dateLabel)
        
        categoryDateConstraints()
    }
    
    func categoryDateConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo:   self.contentView.topAnchor, constant: 5).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 20).isActive = true
    }
}
