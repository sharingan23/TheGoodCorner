//
//  DetailedViewController.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 20/04/2021.
//

import UIKit

class DetailedViewController: UIViewController {

    //MARK: Create View
    let detailTableView = UITableView()
    
    var testData = [["one"],
                    ["title","3","4"],
                    ["Description"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        setupDetailedTableView()
        
    }
    
    //MARK: Setup View
    func setupDetailedTableView() {
        view.addSubview(detailTableView)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.register(ImageItemCellTableViewCell.self, forCellReuseIdentifier: Constants.CellID.detailImageCellID)
        detailTableView.register(DetailCell.self, forCellReuseIdentifier: Constants.CellID.detailCellID)
        detailTableView.register(DescriptionCell.self, forCellReuseIdentifier: Constants.CellID.descriptionCellID)
        
        detailTableView.backgroundColor = UIColor.clear
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
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData[section].count
    }
    
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
        switch testData[indexPath.section][indexPath.row] {
        case "one":
            return 300
        case "2":
            return 20
        case "Description":
            return 200
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.detailImageCellID,
                                                                   for: indexPath) as? ImageItemCellTableViewCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.descriptionCellID,
                                                                   for: indexPath) as? DescriptionCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            
            cell.descriptionTextView.backgroundColor = .green
            
            cell.descriptionTextView.text = "In this short Swift code example, you will learn how to create UITextView programmatically in Swift.Create UITextView programmaticallyPosition UITextView at a specific location within a viewPosition UITextView at the center of the viewChange UITextView text colors Change UITextView background color"
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.detailCellID,
                                                                   for: indexPath) as? DetailCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            
            if testData[indexPath.section][indexPath.row] == "title" {
                cell.detailLabelTitle.font = UIFont.systemFont(ofSize: 20)
            }
            cell.backgroundColor = .white
            cell.detailLabelTitle.text = testData[indexPath.section][indexPath.row]
            return cell
        }
    }
}
