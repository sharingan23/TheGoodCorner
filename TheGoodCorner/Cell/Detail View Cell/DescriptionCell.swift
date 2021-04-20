//
//  DescriptionCell.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 20/04/2021.
//

import UIKit

class DescriptionCell: UITableViewCell {

    let descriptionTextView = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupdescriptionTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupdescriptionTextView() {
        self.contentView.addSubview(descriptionTextView)
        
        descriptionTextViewConstraints()
    }
    
    func descriptionTextViewConstraints() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionTextView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
}
