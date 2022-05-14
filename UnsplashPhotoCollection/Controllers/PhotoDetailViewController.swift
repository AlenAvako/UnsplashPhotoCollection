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
    
    private let inspector = PhotoInspector()
    
    private let photoId: String
    
    override func loadView() {
        super.loadView()
        
        view = photoDetailView
        
        getData(id: photoId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(photoId: String) {
        self.photoId = photoId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(id: String) {
        self.delegate = inspector

        PhotoStore.shared.fetchPhotos()

        if self.delegate?.checkForLike(id: id) == true {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
            let largeBoldDoc = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
            self.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
        }
        
        networkDF.getLocation(photoId: id) { [weak self] result in
            guard let data = result else { return }

            guard let urlString = data.urls["regular"] else { return }
            guard let url = URL(string: (urlString)) else { return }
            
            guard let latitude = data.location?.position?.latitude, let longitude = data.location?.position?.longitude, let city = data.location?.city, let country = data.location?.country else { return }
            
            self?.photoDetailView.setUpView(id: data.id, url: url, name: data.user.name, date: data.created_at, downloads: data.downloads, width: data.width, height: data.height, latitude: latitude, longitude: longitude, city: city, country: country)
            
            guard let latitude = data.location?.position?.latitude, let longitude = data.location?.position?.longitude else { return }
            self?.setUpButtons(id: id, latitude: latitude, longitude: longitude)
        } onFailure: { [weak self] resultWL in
            guard let data = resultWL else { return }
            
            guard let urlString = data.urls["regular"] else { return }
            guard let url = URL(string: (urlString)) else { return }
            
            self?.photoDetailView.setUpView(id: data.id, url: url, name: data.user.name, date: data.created_at, downloads: data.downloads, width: data.width, height: data.height, latitude: 0, longitude: 0, city: "", country: "")
            self?.photoDetailView.locationButton.alpha = 0
            self?.setUpButtons(id: id, latitude: 0, longitude: 0)
        }
    }
    
    private func setUpButtons(id: String, latitude: Double, longitude: Double) {
        photoDetailView.dissmissButton.tapButton = {
            self.dismiss(animated: true, completion: nil)
        }
        
        photoDetailView.addToFavoriteButton.tapButton = { [weak self] in
            switch self?.delegate?.checkForLike(id: id) {
            case true:
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                }, completion: {_ in
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                PhotoStore.shared.deletePhoto(id: id)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

                let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
                let largeBoldDoc = UIImage(systemName: "star", withConfiguration: largeConfig)
                self?.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
            case false:
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                } completion: { _ in
                    self?.photoDetailView.addToFavoriteButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
                guard let imageData = self?.photoDetailView.photo.image?.pngData(), let name = self?.photoDetailView.nameLabel.text else { return }

                PhotoStore.shared.createPhoto(id: id, photo: imageData, name: name)
                PhotoStore.shared.fetchPhotos()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

                let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
                let largeBoldDoc = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
                self?.photoDetailView.addToFavoriteButton.setImage(largeBoldDoc, for: .normal)
            default:
                break
            }
        }
    }
}

