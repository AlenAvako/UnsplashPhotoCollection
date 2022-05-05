//
//  FavoritePhotoArray.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 05.05.2022.
//

import Foundation

struct FavoritePhotoArray {
    static var photoArray = [FavoritePhoto]()
    
    func addnewPhoto(_ photo: FavoritePhoto) {
        FavoritePhotoArray.photoArray.append(photo)
    }
    
    func deletePhoto(_ photo: FavoritePhoto) {
        for (index, value) in FavoritePhotoArray.photoArray.enumerated() {
            if photo.id == value.id {
                FavoritePhotoArray.photoArray.remove(at: index)
            }
        }
    }
}
