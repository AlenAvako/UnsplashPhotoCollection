//
//  NetworkDetailDataFetcher.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 01.05.2022.
//

import Foundation

class NetworkDetailDataFetcher {
    
    private var networkService = NetworkDetailService()
    
    func getLocation(photoId: String, completion: @escaping (PhotoDetail?) -> ()) {
        networkService.request(id: photoId) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PhotoDetail.self, from: data)
            completion(decode)
        }
    }
    
    func getResult(photoId: String, completion: @escaping (PhotoDetailWithoutLocation?) -> ()) {
        networkService.request(id: photoId) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PhotoDetailWithoutLocation.self, from: data)
            completion(decode)
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
