//
//  NetworkDataFetcher.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import Foundation

class NetworkDataFetcher {
    
    private let networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResult?) -> ()) {
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResult.self, from: data)
            completion(decode)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        }
        catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
