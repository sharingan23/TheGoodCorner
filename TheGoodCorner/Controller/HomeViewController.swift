//
//  ViewController.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: ViewModel
    private var adViewModel : AdViewModel?
    private var categoryViewModel : CategoryViewModel?
    
    //MARK: UIView
    let adsCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .clear
            return cv
        }()
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    //MARK: Label
    var noAdTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = Constants.ErrorString.oopsMsg
        label.numberOfLines = 0
        return label
    }()
    
    var noAdLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = Constants.ErrorString.noAdMsg
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: Images
    let NoItemImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.backgroundColor = .clear
        theImageView.contentMode = .scaleAspectFill
        theImageView.image = UIImage(named: Constants.ImageString.noItem)
        return theImageView
    }()
    
    
    //MARK: ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Add to View
        setupNoAdTitleLabl()
        setupNoAdLabl()
        setupNoItemImage()
        setupCategoryCollectionView()
        setGradientBackground()
    
        hideNoItemMsg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showActivityIndicator()
        
        if Reachability.isConnectedToNetwork() {
            callToViewModelForUIUpdate()
            callToCategoryViewModelForUIUpdate()
        } else {
            showAlertNoInternet()
        }
    }
    
    //MARK: Setup View
    
    func setupCategoryCollectionView() {
            view.addSubview(adsCollectionView)
            adsCollectionView.delegate = self
            adsCollectionView.dataSource = self
            adsCollectionView.register(AdCell.self,
                                            forCellWithReuseIdentifier: Constants.CellID.adCellID)
            
            categoryCollectionConstraints()
        }
    
    func categoryCollectionConstraints() {
        adsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        adsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        adsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        adsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        adsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupNoAdTitleLabl(){
        view.addSubview(self.noAdTitleLabel)
        
        noAdTitleLablConstraints()
    }
    
    func noAdTitleLablConstraints() {
        noAdTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noAdTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noAdTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupNoAdLabl(){
        view.addSubview(self.noAdLabel)
        
        noAdLablConstraints()
    }
    
    func noAdLablConstraints() {
        noAdLabel.translatesAutoresizingMaskIntoConstraints = false
        noAdLabel.topAnchor.constraint(equalTo: noAdTitleLabel.bottomAnchor,constant: 10).isActive = true
        noAdLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        noAdLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        noAdLabel.centerXAnchor.constraint(equalTo: noAdTitleLabel.centerXAnchor).isActive = true
    }
    
    func setupNoItemImage(){
        view.addSubview(self.NoItemImageView)
        
        noItemImageConstraints()
    }
    
    func noItemImageConstraints() {
        NoItemImageView.translatesAutoresizingMaskIntoConstraints = false
        NoItemImageView.bottomAnchor.constraint(equalTo: noAdTitleLabel.topAnchor,constant: -10).isActive = true
        NoItemImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        NoItemImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        NoItemImageView.centerXAnchor.constraint(equalTo: noAdTitleLabel.centerXAnchor).isActive = true
    }
    
    //MARK: UI Update
    func callToViewModelForUIUpdate() {
        self.adViewModel = AdViewModel()
        
        if let unwrapadViewModel = self.adViewModel {
            unwrapadViewModel.bindAdViewModelToController = {
                DispatchQueue.main.async {
                    if unwrapadViewModel.adData != nil && unwrapadViewModel.adData.count != 0 {
                        self.hideNoItemMsg()
                    } else {
                        self.showNoItemMsg()
                    }
                    self.adsCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            self.activityIndicator.stopAnimating()
            showNoItemMsg()
        }
    }
    
    func callToCategoryViewModelForUIUpdate() {
        self.categoryViewModel = CategoryViewModel()
        
        if let unwrapCategoryViewModel = self.categoryViewModel {
        }
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 33/255.0, green: 147/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func showNoItemMsg() {
        adsCollectionView.isHidden = true
        NoItemImageView.isHidden = false
        noAdTitleLabel.isHidden = false
        noAdLabel.isHidden = false
    }
    
    func hideNoItemMsg() {
        adsCollectionView.isHidden = false
        NoItemImageView.isHidden = true
        noAdTitleLabel.isHidden = true
        noAdLabel.isHidden = true
    }
    
    func showActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        activityIndicator
            .centerXAnchor
            .constraint(equalTo: view.centerXAnchor)
            .isActive = true
        
        activityIndicator
            .centerYAnchor
            .constraint(equalTo: view.centerYAnchor)
            .isActive = true
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    //MARK: Alert
    func showAlertNoInternet() {
        let alert = UIAlertController(title: Constants.ErrorString.alertTitle,
                                      message: Constants.ErrorString.alertNoInternetMsg,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: Constants.ErrorString.okAction,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let unwrapAdViewModel = adViewModel {
            if unwrapAdViewModel.adData != nil {
                return  unwrapAdViewModel.adData.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.adCellID,
                                                               for: indexPath) as? AdCell
                else {
                        fatalError("DequeueReusableCell failed while casting")
                }
        
        var priceItem = Constants.itemString.noValue
        var titleItem = Constants.itemString.noValue
        var categoryItem = Constants.itemString.noValue
        
        cell.urgentImageView.isHidden = true
        
        if let unwrapAdViewModel = adViewModel {
            if let unwrapTitle = unwrapAdViewModel.adData[indexPath.row].title {
                titleItem = unwrapTitle
            }
            
            if let unwrapPrice = unwrapAdViewModel.adData[indexPath.row].price {
                priceItem = String(Int(unwrapPrice).formattedWithSeparator) + Constants.itemString.currecy
            }
            
            if let unwrapCategory = unwrapAdViewModel.adData[indexPath.row].categoryID {
                categoryItem = String(unwrapCategory)
            }
            
            if let unwrapUrgent = unwrapAdViewModel.adData[indexPath.row].isUrgent {
                if unwrapUrgent {
                    cell.urgentImageView.isHidden = false
                }
            }
        }
        
        cell.titleLabel.text = titleItem
        cell.priceLabel.text = priceItem
        cell.categoryLabel.text = categoryItem
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        if ((indexPath.row % 2) != 0) {
            
        } else {
            
        }
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.2)
    }
}
