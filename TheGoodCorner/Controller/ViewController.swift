//
//  ViewController.swift
//  TheGoodCorner
//
//  Created by Vigneswaranathan Sugeethkumar on 16/04/2021.
//

import UIKit

class ViewController: UIViewController {
    private var adViewModel : AdViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callToViewModelForUIUpdate()
        
    }
    
    func callToViewModelForUIUpdate() {
        self.adViewModel = AdViewModel()
    }
}

