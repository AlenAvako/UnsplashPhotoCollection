//
//  CollectionDataFetcher.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 04.05.2022.
//

import UIKit

struct CollectionDataFetcher {
    private var fetcher = NetworkDataFetcher()
    
    private let photoArray = SearchPhotoArray()
    
    func fetchPhotos(_ collectionView: UICollectionView, searchTerm: String) {
        fetcher.fetchImages(searchTerm: searchTerm, completion: { response in
            guard let photoResponse = response else { return }
            photoArray.getPhotoArray(photoResponse.results)
            collectionView.reloadData()
        })
    }
}
