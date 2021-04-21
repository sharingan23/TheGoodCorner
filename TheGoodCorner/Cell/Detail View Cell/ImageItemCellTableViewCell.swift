//
//  ImageItemCellTableViewCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 20/04/2021.
//

import UIKit

class ImageItemCellTableViewCell: UITableViewCell {
    
    let ImageViewItem: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: Constants.ImageString.noPhoto)
        theImageView.contentMode = .scaleAspectFill
        theImageView.layer.masksToBounds = true
        theImageView.backgroundColor = .white
        return theImageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupImageItemView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    func setupImageItemView() {
        ImageViewItem.frame.size = self.contentView.frame.size
        
        self.contentView.addSubview(ImageViewItem)
        
        imageViewItemConstraints()
    }
    
    func imageViewItemConstraints() {
        ImageViewItem.translatesAutoresizingMaskIntoConstraints = false
        
        ImageViewItem.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: 0).isActive = true
        ImageViewItem.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        ImageViewItem.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 0).isActive = true
        ImageViewItem.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 0).isActive = true
    }
}
