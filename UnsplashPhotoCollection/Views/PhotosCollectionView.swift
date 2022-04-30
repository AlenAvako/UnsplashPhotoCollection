//
//  PhotosCollectionView.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 29.04.2022.
//

import UIKit

final class PhotosCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView() {
        self.backgroundColor = .systemYellow
    }
}

