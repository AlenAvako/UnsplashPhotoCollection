//
//  PhotoDetailViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    private var photoInfo: PhotoInfo?
    
    init(photoInfo: PhotoInfo) {
        self.photoInfo = photoInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }


}
