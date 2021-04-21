//
//  DetailedViewController.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 20/04/2021.
//

import UIKit

class DetailedViewController: UIViewController {

    //MARK: Create View
    var indexItem: Int?
    var categoryViewModel: CategoryViewModel?
    var adArray: [Ad]?
    var twoDimensionalArr = [[String]]()
    
    var imageItem = UIImage(named: Constants.ImageString.noPhoto)
    
    let detailTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .detailViewColor
        
        createTwoDimensialArray()
        setupDetailedTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Constants.textString.appName
     }
    
    //MARK: Helpers
    func createTwoDimensialArray(){
        if let unwrapAd = adArray {
            if let unwrapIndex = indexItem {
                if  imageItem != nil {
                    if let unwrapDescription = unwrapAd[unwrapIndex].description {
                        let twoDimensionalArray = [["Image"],
                                                   arrayOfDetails(ad: unwrapAd[unwrapIndex]),
                                                   [unwrapDescription]
                                                   
                        ]
                        
                        twoDimensionalArr = twoDimensionalArray
                    }
                }
            }
        }

    }
    func arrayOfDetails(ad: Ad) -> [String] {
        var array = [String]()
        
        if let unwrapTitle = ad.title {
            title = unwrapTitle
            
            array.append(unwrapTitle)
        }
        
        if let unwrapPrice = ad.price {
            array.append(String(unwrapPrice.formattedWithSeparator) + Constants.itemString.currecy)
        }
        
        if let unwrapDateString = ad.creationDate{
            if let unwrapDate = unwrapDateString.toDate() {
                let dateCreated = unwrapDate.getFormattedDate(format: Constants.dateFormat.dateFormat)
                
                array.append(String(dateCreated))
            }
        }
        
        if let unwrapCategory = ad.categoryID {
            if let unwrapCategoryModel = categoryViewModel {
               let categoryString = unwrapCategoryModel.getCategoryFromInt(id: unwrapCategory)
                
                if let unwrapCategory = categoryString {
                    array.append(unwrapCategory)
                }
            }
        }
        
        if let unwrapUrgent = ad.isUrgent {
            if unwrapUrgent {
                array.append(Constants.detailString.urgent)
            }
        }
        
        if let unwrapSiret = ad.siret{
            array.append(String(unwrapSiret))
        }
        
        return array
    }
    
    //MARK: Setup View
    func setupDetailedTableView() {
        view.addSubview(detailTableView)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        detailTableView.backgroundColor = .clear
        
        self.detailTableView.rowHeight = 44
        
        detailTableView.register(ImageItemCellTableViewCell.self, forCellReuseIdentifier: Constants.CellID.detailImageCellID)
        detailTableView.register(DetailCell.self, forCellReuseIdentifier: Constants.CellID.detailCellID)
        detailTableView.register(DescriptionCell.self, forCellReuseIdentifier: Constants.CellID.descriptionCellID)
        
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        
        detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      }
}

//MARK: Extension
extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArr[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel:UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.textColor = UIColor.selectedCategoryBackgroundLblColor
            label.adjustsFontSizeToFitWidth = false
            label.lineBreakMode = .byTruncatingTail
            label.font = UIFont.systemFont(ofSize: 18)
            label.numberOfLines = 1
            return label
        }()
    
        headerLabel.backgroundColor = .clear
    
        switch section {
        case 0:
            return nil
        case 1:
            return nil
        case 2:
            headerLabel.text = Constants.detailString.descriptionHeader
            
            return headerLabel
        default:
            return headerLabel
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 || section == 0 {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 250
        }
        if indexPath.section == 2 {
            return 300
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 10))
        v.backgroundColor = .descriptionBackgroundColor
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Section Footer height
        let footerHeight = CGFloat(5)
        switch section {
        case 1:
            return footerHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Image Cell
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.detailImageCellID,
                                                                   for: indexPath) as? ImageItemCellTableViewCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            cell.ImageViewItem.image = imageItem
            
            return cell
        //Description Cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.descriptionCellID,
                                                                   for: indexPath) as? DescriptionCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            
            cell.backgroundColor = .descriptionBackgroundColor
            
            cell.descriptionTextView.backgroundColor = UIColor.clear
            cell.descriptionTextView.textColor = .black
            cell.descriptionTextView.text = twoDimensionalArr[indexPath.section][indexPath.row]
            
            return cell
        default:
            //Details Cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.detailCellID,
                                                                   for: indexPath) as? DetailCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            
            cell.detailLabelTitle.textColor = .detailTextColor
            
            switch indexPath.row {
            //Title
            case 0:
                cell.detailLabelTitle.font = UIFont.boldSystemFont(ofSize: 24)
                cell.detailLabelTitle.textColor = UIColor.black
                cell.detailLabelTitle.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 5).isActive = true
                
                cell.backgroundColor = .clear
                cell.iconDetailImageView.isHidden = true
                
            //Price
            case 1:
                cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.price)
                cell.detailLabelTitle.font = UIFont.boldSystemFont(ofSize: 20)
                
                cell.backgroundColor = .clear

                cell.detailLabelTitle.textColor = UIColor.black
            
            //Date
            case 2:
                cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.calendar)
                cell.backgroundColor = .clear

            
            //Category:
            case 3:
                cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.category)
                cell.backgroundColor = .clear

            
            //Urgent or Siret
            case 4:
                if twoDimensionalArr[indexPath.section][indexPath.row] == Constants.detailString.urgent {
                    cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.starDetail)
                } else {
                    cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.siret)
                }
                
                cell.backgroundColor = .clear

                
            //siret
            case 5:
                cell.iconDetailImageView.image = UIImage(named: Constants.ImageString.siret)

            default:
                cell.detailLabelTitle.textColor = .unSelectedCategoryBackgroundLblColor
            }
            
            cell.detailLabelTitle.text = twoDimensionalArr[indexPath.section][indexPath.row]
            
            return cell
        }
    }
}
