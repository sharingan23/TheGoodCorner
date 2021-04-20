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
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        detailLabelTitle.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 5).isActive = true
        detailLabelTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        //detailLabelTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0).isActive = true
    }
}
