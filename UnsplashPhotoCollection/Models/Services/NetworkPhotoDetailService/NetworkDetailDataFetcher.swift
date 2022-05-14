//
//  NetworkDetailDataFetcher.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 01.05.2022.
//

import Foundation

class NetworkDetailDataFetcher {
    
    private var networkService = NetworkDetailService()
    
    func getLocation(photoId: String, completion: @escaping (PhotoDetail?) -> (), onFailure: @escaping (PhotoDetailWithoutLocation?) -> ()) {
        networkService.request(id: photoId) { (data, error) in
//            if let error = error {
//                print("Error received requesting data: \(error.localizedDescription)")
//                completion(nil)
//            }
            
            if let decode = self.decodeJSON(type: PhotoDetail.self, from: data) {
                completion(decode)
            } else if let onFailureDecode = self.decodeJSON(type: PhotoDetailWithoutLocation.self, from: data) {
                onFailure(onFailureDecode)
            }
        }
    }

    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
