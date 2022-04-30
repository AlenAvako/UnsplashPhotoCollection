//
//  SearchResult.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let results: [Photo]
}

struct Photo: Decodable {
    let id: String
    let created_at: String
    let urls: [URLKind.RawValue: String]
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
