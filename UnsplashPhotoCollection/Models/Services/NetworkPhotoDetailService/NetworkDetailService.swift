//
//  NetworkDetailService.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 01.05.2022.
//

import Foundation

class NetworkDetailService {
    
    func request(id: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(id: id)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID iHEu-ziw3QeBbHVXlZImlDmHrNYHusty5ser2h-X6tI"
        return headers
    }
    
    private func url(id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/\(id)"
        return components.url!
    }
    
    private func createDataTask(from reqest: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: reqest) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
