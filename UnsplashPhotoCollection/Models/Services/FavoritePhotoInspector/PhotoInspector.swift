//
//  PhotoInspector.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 05.05.2022.
//

import UIKit

class PhotoInspector: PhotoDetailViewControllerDelegate {

    private let checker = Checker.shared
    
    func checkForLike(id: String) -> Bool {
        checker.checkLike(id: id)
        
        checker.newValue = ""
        
        return checker.isLikedByUser
    }
}

