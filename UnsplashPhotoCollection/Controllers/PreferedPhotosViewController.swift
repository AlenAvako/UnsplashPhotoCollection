//
//  PreferedPhotosViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class PreferedPhotosViewController: UIViewController {
    
    let tableView = PreferedPhotoTableView()
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
