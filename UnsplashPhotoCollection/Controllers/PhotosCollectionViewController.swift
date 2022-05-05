//
//  PhotosCollectionViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 29.04.2022.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    private var photos = [Photo]()
    
    private let networkDF = CollectionDataFetcher()
    
    private let photosCollectionView = PhotosCollectionView()
    
    override func loadView() {
        super.loadView()
        
        view = photosCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchBar()
        setUpCollectionView()
    }

    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor(named: "AppGreen")
        searchController.searchBar.delegate = self
    }
    
    private func setUpCollectionView() {
        networkDF.fetchPhotos(photosCollectionView, searchTerm: "Hello")
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        networkDF.fetchPhotos(photosCollectionView, searchTerm: searchText)
    }
}

extension PhotosCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchPhotoArray.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        cell.unsplashPhoto = SearchPhotoArray.photoArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let accessibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = accessibleWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = SearchPhotoArray.photoArray[indexPath.item]
        
        let photoDetailVC = PhotoDetailViewController()
        photoDetailVC.getData(id: photo.id)
        navigationController?.present(photoDetailVC, animated: true, completion: nil)
    }
}

