//
//  PhotoDetail.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import Foundation

struct PhotoDetail: Decodable {
    let downloads: Int
    var location: Location?
    let user: UserInfo
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

struct UserInfo: Decodable {
    let name: String
}
