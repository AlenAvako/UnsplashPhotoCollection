//
//  PhotoDetailViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

protocol PhotoDetailViewControllerDelegate: AnyObject {
    func checkForLike(id: String) -> Bool
}

class PhotoDetailViewController: UIViewController {
    
    weak var delegate: PhotoDetailViewControllerDelegate?
    
    private let photoDetailView = PhotoDetailView()
    
    private let networkDF = NetworkDetailDataFetcher()
    
    private let inspector = FavoritePhotoInspector()
    
    override func loadView() {
        super.loadView()
        
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func getData(id: String) {
        self.delegate = inspector
        
        if self.delegate?.checkForLike(id: id) == true {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
            let largeBoldDoc = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
            self.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
        }
        
        networkDF.getLocation(photoId: id) { [weak self] result in
            if result != nil {
                guard let data = result else { return }

                guard let urlString = data.urls["regular"] else { return }
                guard let url = URL(string: (urlString)) else { return }

                self?.photoDetailView.setUpView(url: url, name: data.user.name, date: data.created_at, downloads: data.downloads, width: data.width, height: data.height)
            } else {
                self?.networkDF.getResult(photoId: id) { [weak self] resultWL in
                    guard let data = resultWL else { return }
                    
                    guard let urlString = data.urls["regular"] else { return }
                    guard let url = URL(string: (urlString)) else { return }
                    
                    self?.photoDetailView.setUpView(url: url, name: data.user.name, date: data.created_at, downloads: data.downloads, width: data.width, height: data.height)
                }
            }
        }
        
        setUpButtons(id: id)
    }
    
    private func setUpButtons(id: String) {
        
        let favoriteArray = FavoritePhotoArray()
        
        photoDetailView.dissmissButton.tapButton = {
            self.dismiss(animated: true, completion: nil)
        }
        
        photoDetailView.addToFavoriteButton.tapButton = { [weak self] in
            let newPhoto = FavoritePhoto(id: id)
            
            switch self?.delegate?.checkForLike(id: id) {
            case true:
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                }, completion: {_ in
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                favoriteArray.deletePhoto(newPhoto)
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
                let largeBoldDoc = UIImage(systemName: "star", withConfiguration: largeConfig)
                self?.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
            case false:
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                } completion: { _ in
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                favoriteArray.addnewPhoto(newPhoto)
                let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
                let largeBoldDoc = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
                self?.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
            default:
                break
            }
        }
    }
}

