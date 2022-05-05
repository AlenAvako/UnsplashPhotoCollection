//
//  Checker.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 05.05.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    var isLikedByUser: Bool = false
    
    var newValue: String = ""
    
    func checkLike(id: String) {
        for (_, value) in FavoritePhotoArray.photoArray.enumerated() {
            if id == value.id {
                newValue = value.id
            }
        }
        
        if newValue == id {
            isLikedByUser = true
        } else {
            isLikedByUser = false
        }
    }
    private init() {}
}
