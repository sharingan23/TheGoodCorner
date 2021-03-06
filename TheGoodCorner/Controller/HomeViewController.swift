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
    var imageItem = UIImage(named: Constants.ImageString.noPhoto)
    
    //MARK: UIView
    let adsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    var searchBar = UISearchBar()
    
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
    
    var borderLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = UIColor.lightGray
        label.adjustsFontSizeToFitWidth = false
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
    
    //MARK: Int
    var indexSelectedCategoryCell = 0
    
    //MARK: Filtered Local Data
    var filteredLocalData: [Ad]?
    
    //MARK: ViewController Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Add to View
        setSearchBarUI()
        showActivityIndicator()
        setupNoAdTitleLabl()
        setupNoAdLabl()
        setupNoItemImage()
        setupCategoryCollectionView()
        setupBorderLabl()
        setupAdsCollectionView()
        UIColor.setGradientBackgroundColorView(view: view)
        hideNoItemMsg()
        
        //Look for single or multiple tap
        setTapRecognizer()
        
        //Check if internet is available
        if Reachability.isConnectedToNetwork() {
            callToViewModelForUIUpdate()
            callToCategoryViewModelForUIUpdate()
        } else {
            activityIndicator.stopAnimating()
            showNoItemMsg()
            showAlertNoInternet()
        }
        
        //Remove back button text
        navigationItem.backButtonTitle = Constants.itemString.noValue
    }
    
    //MARK: Selectors
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        searchBar.resignFirstResponder()
        view.endEditing(true)
    }
    
    //MARK: Setup UICollectionView
    func setupAdsCollectionView() {
            view.addSubview(adsCollectionView)
            adsCollectionView.delegate = self
            adsCollectionView.dataSource = self
        adsCollectionView.keyboardDismissMode = .onDrag
            adsCollectionView.register(AdCell.self,
                                            forCellWithReuseIdentifier: Constants.CellID.adCellID)
            
            adsCollectionConstraints()
        }
    
    func adsCollectionConstraints() {
        adsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        adsCollectionView.topAnchor.constraint(equalTo: borderLabel.bottomAnchor, constant: 0).isActive = true
        adsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        adsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        adsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupCategoryCollectionView() {
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCell.self,
                                        forCellWithReuseIdentifier: Constants.CellID.categoryCellID)
            
        categoryCollectionConstraints()
    }
    
    func categoryCollectionConstraints() {
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        categoryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        categoryCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: Setup Label
    func setupNoAdTitleLabl(){
        view.addSubview(self.noAdTitleLabel)
        
        noAdTitleLablConstraints()
    }
    
    func noAdTitleLablConstraints() {
        noAdTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noAdTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noAdTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupBorderLabl(){
        view.addSubview(self.borderLabel)
        
        borderLablConstraints()
    }
    
    func borderLablConstraints() {
        borderLabel.translatesAutoresizingMaskIntoConstraints = false
        borderLabel.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 0).isActive = true
        borderLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 0).isActive = true
        borderLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 0).isActive = true
        borderLabel.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
    
    //MARK: Setup UIImageView
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
    
    func setSearchBarUI() {
        //set Searchbar
        searchBar.sizeToFit()
        searchBar.placeholder = Constants.textString.searchPlaceholder
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationItem.largeTitleDisplayMode = .always
        //set Urgent bar button
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.textString.appName
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        showSearchBarButton(shouldShow: true)
        search(shouldShow: false)
    }
    
    func urgentButonBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Urgent", style: .plain, target: self, action:  #selector(handleShowSearchBar))
    }
    
    
    func showSearchBarButton(shouldShow: Bool) {
            if shouldShow {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                    target: self,
                                                                    action: #selector(handleShowSearchBar))
            } else {
                navigationItem.rightBarButtonItem = nil
            }
        }
        
        func search(shouldShow: Bool) {
            showSearchBarButton(shouldShow: !shouldShow)
            searchBar.showsCancelButton = shouldShow
            navigationItem.titleView = shouldShow ? searchBar : nil
        }
    
    func setTapRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //MARK: UI Update from ViewModel
    func callToViewModelForUIUpdate() {
        // init View Model and loading data
        self.adViewModel = AdViewModel()
        hideNoItemMsg()
        if let unwrapadViewModel = self.adViewModel {
            unwrapadViewModel.bindAdViewModelToController = {
                DispatchQueue.main.async {
                    if unwrapadViewModel.adData != nil && unwrapadViewModel.adData.count != 0 {
                        self.hideNoItemMsg()
                        self.filteredLocalData = unwrapadViewModel.adData
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
        // init View Model and loading data
        self.categoryViewModel = CategoryViewModel()
        
        if let unwrapCategoryViewModel = self.categoryViewModel {
            unwrapCategoryViewModel.bindCategoryViewModelToController = {
                DispatchQueue.main.async {
                    self.categoryCollectionView.reloadData()
                }

            }
        }
    }
    
    //MARK: UI Set up    
    func animationOnReloadData(collectionView: UICollectionView) {
        UIView.transition(with: adsCollectionView,
                          duration: 0.35,
                          options: .transitionFlipFromLeft,
                          animations: { self.adsCollectionView.reloadData() })
    }
    
    //MARK: function to hide or show msg if no ads.
    func showNoItemMsg() {
        adsCollectionView.isHidden = true
        borderLabel.isHidden = true
        NoItemImageView.isHidden = false
        noAdTitleLabel.isHidden = false
        noAdLabel.isHidden = false
    }
    
    func hideNoItemMsg() {
        adsCollectionView.isHidden = false
        borderLabel.isHidden = false
        NoItemImageView.isHidden = true
        noAdTitleLabel.isHidden = true
        noAdLabel.isHidden = true
    }
    
    //MARK: State handler of Category CollectionView
    func stateHandlerCategoryCollectionView(cell: CategoryCell,isSelected: Bool) {
        if isSelected {
            cell.backgroundColor = UIColor.white
            cell.categoryLabel.textColor = UIColor.unSelectedCategoryBackgroundLblColor
        } else {
            cell.backgroundColor = UIColor.unSelectedCategoryBackgroundLblColor
            cell.categoryLabel.textColor = UIColor.white
        }
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
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.ErrorString.alertTitle, message: Constants.ErrorString.alertNoInternetMsg, preferredStyle: .alert)

            let okAction = UIAlertAction(title: Constants.ErrorString.okAction, style: .cancel, handler: nil)

            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: Extension UICollectionView
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            if let unwrapCategoryViewModel = categoryViewModel {
                if let unwrapCategoryData = unwrapCategoryViewModel.categoryData {
                    return unwrapCategoryData.count
                } else {
                    return 0
                }
            } else {
                return 0
            }
            
        case adsCollectionView:
                if let unwrapFilteredData = filteredLocalData {
                    if !unwrapFilteredData.isEmpty {
                        hideNoItemMsg()
                    }
                    return unwrapFilteredData.count
                } else {
                    return 0
                }
        default:
            showNoItemMsg()
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Category CollectionView
        if collectionView == categoryCollectionView {
            guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.categoryCellID,
                                                                   for: indexPath) as? CategoryCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
            
            stateHandlerCategoryCollectionView(cell: categoryCell, isSelected: false)
            
            if indexSelectedCategoryCell == indexPath.row {
                stateHandlerCategoryCollectionView(cell: categoryCell, isSelected: true)
            }
            
            categoryCell.categoryLabel.text = Constants.itemString.noValue
            
            if let unwrapCategoryViewModel = categoryViewModel {
                if let unwrapCategoryData = unwrapCategoryViewModel.categoryData {
                    categoryCell.categoryLabel.text = unwrapCategoryData[indexPath.row].name
                }
            }
            
            return categoryCell
        } else {
            // Ad CollectionView
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.adCellID,
                                                                   for: indexPath) as? AdCell
                    else {
                            fatalError("DequeueReusableCell failed while casting")
                    }
        
            var priceItem = Constants.itemString.noValue
            var titleItem = Constants.itemString.noValue
            var categoryItem = Constants.itemString.noValue
            
            cell.urgentImageView.isHidden = true
            
            cell.ImageViewItem.image = UIImage(named: Constants.ImageString.noPhoto)
            
            if let unwrapAdViewModel = adViewModel {
            if let unwrapFilteredAd = filteredLocalData {
                if let unwrapTitle = unwrapFilteredAd[indexPath.row].title {
                    titleItem = unwrapTitle
                }
                
                if let unwrapPrice = unwrapFilteredAd[indexPath.row].price {
                    // Adding thousand separator
                    priceItem = String(Int(unwrapPrice).formattedWithSeparator) + Constants.itemString.currecy
                }
                
                //Get id of category from ViewModel
                if let unwrapCategoryID = unwrapFilteredAd[indexPath.row].categoryID {

                    if let unwrapCategoryViewModel = categoryViewModel {
                        //Get Name of the category from id with ViewModel
                        if let category = unwrapCategoryViewModel.getCategoryFromInt(id: unwrapCategoryID) {
                            categoryItem = category
                        }
                    }
                }
                
                if let unwrapIsUrgent = unwrapFilteredAd[indexPath.row].isUrgent {
                    if unwrapIsUrgent {
                        cell.urgentImageView.isHidden = false
                    }
                }
                
                if let unwrapDateString = unwrapFilteredAd[indexPath.row].creationDate {
                    // Convert String to date and change date format
                    if let unwrapDate = unwrapDateString.toDate() {
                        cell.dateLabel.text = unwrapDate.getFormattedDate(format: Constants.dateFormat.homeDateFormat)
                    }
                }
                
                
                if let unwrapUrlString = unwrapFilteredAd[indexPath.row].imagesURL {
                    
                    let imgUrl = URL(string: unwrapUrlString.small)
                    if let unwrapImgUrl = imgUrl {
                        // Download Image from url
                            unwrapAdViewModel.callFuncToGetImageData(url: unwrapImgUrl, completionHandler: { (data, error) in
                                if let unwrapData = data {
                                    cell.ImageViewItem.image = UIImage(data: unwrapData)
                                    self.imageItem = UIImage(data: unwrapData)
                                }
                            })
                        }
                    }
                }
            }
            
            cell.titleLabel.text = titleItem
            cell.priceLabel.text = priceItem
            cell.categoryLabel.text = categoryItem
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case categoryCollectionView:
            if collectionView == categoryCollectionView {
                var widthCell = 70
                if let unwrapCategoryViewModel = categoryViewModel {
                    if let unwrapCategoryData = unwrapCategoryViewModel.categoryData {
                        let label = UILabel(frame: CGRect.zero)
                                label.text = unwrapCategoryData[indexPath.row].name
                                label.sizeToFit()
                        widthCell = Int(label.frame.width)
                        // Handle too small Widht Cell
                        if widthCell < 50 {
                            widthCell = 55
                        }
                    }
                }
                return CGSize(width: widthCell, height: 35)
            }
        case adsCollectionView:
            
            let padding: CGFloat =  10
            let collectionViewSize = collectionView.frame.size.width - padding
            
            if ((indexPath.row % 2) != 0) {
                
            } else {
                
            }
            return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.2)
        default:
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UIApplication.shared.isKeyboardPresented {
            searchBar.resignFirstResponder()
            view.endEditing(true)
        } else {
            if collectionView == adsCollectionView {
                let adCell = collectionView.cellForItem(at: indexPath) as? AdCell
                
                // Pushing to detail view
                if collectionView == adsCollectionView {
                    if let navigator = navigationController {
                        let detailledVC = DetailedViewController()
                        if let unwrapCell = adCell {
                            detailledVC.imageItem = unwrapCell.ImageViewItem.image
                            detailledVC.indexItem = indexPath.row
                            //Check if categoryw
                            if let unwrapCategoryViewModel = categoryViewModel {
                                detailledVC.categoryViewModel = unwrapCategoryViewModel
                            }
                            
                            detailledVC.adArray = filteredLocalData
                            
                            navigator.pushViewController(detailledVC, animated: true)
                        }
                    }
                }
            }
        }
        if collectionView == categoryCollectionView {
            filteredLocalData = nil
            //Selected category indexy
            indexSelectedCategoryCell = indexPath.row
            
            // reset search bar text
            searchBar.text = Constants.itemString.noValue
            
            if let unwrapCategoryViewModel = categoryViewModel {
                if let unwrapCategoryData = unwrapCategoryViewModel.categoryData {
                    
                    if let unwrapAdViewModel = adViewModel {
                       filteredLocalData = unwrapAdViewModel.filterByCategory(arrayAd: unwrapAdViewModel.adData, category: unwrapCategoryData[indexPath.row])
                        animationOnReloadData(collectionView: adsCollectionView)
                    }
                }
            }
            categoryCollectionView.reloadData()
        }
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == Constants.itemString.noValue {
            adsCollectionView.reloadData()
        } else {
            if let unwrapAdViewModel = adViewModel {
                filteredLocalData = unwrapAdViewModel.filterBySearch(arrayAd: unwrapAdViewModel.adData, searchedText: searchText)
                
                if let unwrapFilteredLocalData = filteredLocalData {
                    if let unwrapCategoryViewModel = categoryViewModel {
                        if let unwrapCategoryData = unwrapCategoryViewModel.categoryData {
                            
                            if let unwrapAdViewModel = adViewModel {
                               filteredLocalData = unwrapAdViewModel.filterByCategory(arrayAd: unwrapFilteredLocalData, category: unwrapCategoryData[indexSelectedCategoryCell])
                            }
                        }
                    }
                    if filteredLocalData!.isEmpty{
                        showNoItemMsg()
                    }
                } else {
                    showNoItemMsg()
                }
                
                adsCollectionView.reloadData()
                }
        }
    }
}
