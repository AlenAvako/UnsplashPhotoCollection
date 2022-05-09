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
        
        guard let array = PhotoStore.shared.photos else { return }
        for (_, value) in array.enumerated() {
            if id == value.id {
                guard let getValue = value.id else { return }
                newValue = getValue
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
