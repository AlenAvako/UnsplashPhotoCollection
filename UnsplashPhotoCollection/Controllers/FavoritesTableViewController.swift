//
//  FavoritesTableViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    let tableView = FavoritesTableView()
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
