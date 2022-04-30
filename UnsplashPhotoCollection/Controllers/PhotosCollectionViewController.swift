//
//  PhotosCollectionViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 29.04.2022.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    private var photos = [Photo]()
    
    private let networkDF = NetworkDataFetcher()
    
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
        titleLabel.textColor = UIColor(named: "AppGreen")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor(named: "AppGreen")
        searchController.searchBar.delegate = self
    }
    
    private func setUpCollectionView() {
        networkDF.fetchImages(searchTerm: "Hello", completion: { [weak self] result in
            guard let fetchedPhotos = result else { return }
            self?.photos = fetchedPhotos.results
            self?.photosCollectionView.reloadData()
        })
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        networkDF.fetchImages(searchTerm: searchText) { [weak self] searchResult in
            
            guard let fetchedPhotos = searchResult else { return }
            self?.photos = fetchedPhotos.results
            self?.photosCollectionView.reloadData()
        }
    }
}

extension PhotosCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.id, for: indexPath) as! PhotosCollectionViewCell
        cell.unsplashPhoto = photos[indexPath.row]
        
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
        
        let photo = photos[indexPath.item]
        
        let photoDetailVC = PhotoDetailViewController(photoInfo: PhotoInfo(id: photo.id, createdAt: photo.created_at, likedByUser: false, name: "", downloads: ""))
        photoDetailVC.modalPresentationStyle = .fullScreen
        navigationController?.present(photoDetailVC, animated: true, completion: nil)
    }
}

