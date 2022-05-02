//
//  PhotoDetailViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    private let photoDetailView = PhotoDetailView()
    
    private var photoId: String
    
    private let networkDF = NetworkDetailDataFetcher()
    
    init(photoId: String) {
        self.photoId = photoId
        super.init(nibName: nil, bundle: nil)
        
        getData(id: photoId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = photoDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
    }
    
    private func getData(id: String) {
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
    }
    
    private func setUpButtons() {
        photoDetailView.dissmissButton.tapButton = {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

