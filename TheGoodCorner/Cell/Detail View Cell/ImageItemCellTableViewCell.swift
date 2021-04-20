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
        theImageView.backgroundColor = .blue
        theImageView.contentMode = .scaleAspectFit
        theImageView.image = UIImage(named: Constants.ImageString.noPhoto)
        return theImageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
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
        self.contentView.addSubview(ImageViewItem)
        
        imageViewItemConstraints()
    }
    
    func imageViewItemConstraints() {
        ImageViewItem.translatesAutoresizingMaskIntoConstraints = false
        
        ImageViewItem.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: 0).isActive = true
        ImageViewItem.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 0).isActive = true
        ImageViewItem.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        ImageViewItem.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }


}
