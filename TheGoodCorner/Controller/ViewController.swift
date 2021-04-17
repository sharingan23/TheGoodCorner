//
//  ViewController.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import UIKit

class ViewController: UIViewController {
    //MARK: ViewModel
    private var adViewModel : AdViewModel!
    private var categoryViewModel : CategoryViewModel!
    
    //MARK: Variables
    let categoryCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .lightGray
            return cv
        }()
    
    
    //MARK: ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue
        setupCategoryCollectionView()
        callToViewModelForUIUpdate()
        callToCategoryViewModelForUIUpdate()
    }
    
    //MARK: Setup View
    
    func setupCategoryCollectionView() {
            view.addSubview(categoryCollectionView)
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.register(AdCell.self,
                                            forCellWithReuseIdentifier: Constants.CellID.adCellID)
            
            categoryCollectionConstraints()
        }
    
    func categoryCollectionConstraints() {
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        categoryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        categoryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
 
    //MARK: UI Update
    func callToViewModelForUIUpdate() {
        self.adViewModel = AdViewModel()
    }
    
    func callToCategoryViewModelForUIUpdate() {
        self.categoryViewModel = CategoryViewModel()
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.adCellID,
                                                               for: indexPath) as? AdCell
                else {
                        fatalError("DequeueReusableCell failed while casting")
                }
        
        cell.titleLabel.text = "\(indexPath.row)"
        cell.backgroundColor = .white
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

