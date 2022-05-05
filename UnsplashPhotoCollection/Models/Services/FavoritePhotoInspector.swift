//
//  FavoritePhotoInspector.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 05.05.2022.
//

import Foundation

class FavoritePhotoInspector: PhotoDetailViewControllerDelegate {
    
    let checker = Checker.shared
    
    func checkForLike(id: String) -> Bool {
        checker.checkLike(id: id)
        
        checker.newValue = ""
        
        return checker.isLikedByUser
    }
}
