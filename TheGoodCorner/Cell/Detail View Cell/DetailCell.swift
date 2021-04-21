//
//  DetailCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 20/04/2021.
//

import UIKit

class DetailCell: UITableViewCell {

    var detailLabelTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let iconDetailImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.contentMode = .scaleAspectFit
        theImageView.backgroundColor = .clear
        return theImageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupImageItemView()
        setupdetailLabelTitleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    func setupdetailLabelTitleView() {
        self.contentView.addSubview(detailLabelTitle)
        
        detailTitleLabelConstraints()
    }
    
    func detailTitleLabelConstraints() {
        detailLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabelTitle.leftAnchor.constraint(equalTo: self.iconDetailImageView.rightAnchor, constant: 5).isActive = true
        detailLabelTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5).isActive = true
        detailLabelTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2).isActive = true
        detailLabelTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2).isActive = true
    }
    
    func setupImageItemView() {
        self.contentView.addSubview(iconDetailImageView)
        
        imageViewItemConstraints()
    }
    
    func imageViewItemConstraints() {
        iconDetailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iconDetailImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5).isActive = true
        iconDetailImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconDetailImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconDetailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
    }
}
