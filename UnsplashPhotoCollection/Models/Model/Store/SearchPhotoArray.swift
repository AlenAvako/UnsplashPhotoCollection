//
//  SearchPhotoArray.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 04.05.2022.
//

import Foundation

struct SearchPhotoArray {
    static var photoArray = [Photo]()
    
    func getPhotoArray(_ photoArray: [Photo]) {
        SearchPhotoArray.photoArray.removeAll()
        for (_, value) in photoArray.enumerated() {
            SearchPhotoArray.photoArray.append(value)
        }
    }
}
