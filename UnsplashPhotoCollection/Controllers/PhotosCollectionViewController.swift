//
//  PhotosCollectionViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 29.04.2022.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    private let collectionView = PhotosCollectionView()
    
    override func loadView() {
        super.loadView()
        
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchBar()
    }

    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        titleLabel.textColor = UIColor(named: "AppGreen")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor(named: "AppGreen")
        searchController.searchBar.delegate = self
    }
}

extension PhotosCollectionViewController: UISearchBarDelegate {
    
}
