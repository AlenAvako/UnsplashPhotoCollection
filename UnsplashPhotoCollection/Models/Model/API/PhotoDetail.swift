//
//  PhotoDetail.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import Foundation

struct PhotoDetail: Decodable {
    let id: String
    let created_at: String
    let downloads: Int
    let width: Int
    let height: Int
    var location: Location?
    let urls: [URLKind.RawValue: String]
    let user: UserInfo
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct Location: Decodable {
    var city: String = "Unknown"
    var country: String =  "Unknown"
    var position: Position?
}

struct Position: Decodable {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

struct PhotoDetailWithoutLocation: Decodable {
    let id: String
    let created_at: String
    let downloads: Int
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue: String]
    let user: UserInfo
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct UserInfo: Decodable {
    let name: String
}
