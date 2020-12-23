//
//  UnsplashManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 22/12/20.
//

import Foundation


/**
Network Manager for Unsplash requests
 
Use this class to retrieve and translate all data from Unsplash API
 
- Author: Rodrigo Candido
- Version: v1.0
 */
struct UnsplashNetworkManager {
    
    
    
    /// Fetch images based on Weather Condition
    /// - Parameters:
    ///   - imageCase: UnsplashImageCases enum
    ///   - completion: What to do once fetch data is finish successfully or not
    func fetchUsplashImages(by imageCase: UnsplashImageCases, completion: @escaping (Result<UnsplashData?, UnsplashError>) -> Void ){
        
        guard let key = ApiKey.unsplashAccess else { return }
        
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "client_id", value: key),
            URLQueryItem(name: "query", value: imageCase.rawValue),
        ]
        
        guard let urlComponent = self.baseURL(byParameters: queryItems),
              let url = urlComponent.url else { return }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(UnsplashData.self, from: data)
                print(decodedData.results[1].url.full)
                completion(.success(decodedData))
            }catch{
                print(error)
            }
        }
        task.resume()
    }
 
}

// MARK: - Extension for RequestConfigurationProtocol
extension UnsplashNetworkManager: RequestConfigurationProtocol{
    func baseURL(byParameters parameters: [URLQueryItem]?) -> URLComponents? {
        
        var url = URLComponents(string: "https://api.unsplash.com/search/photos")
        url?.queryItems = parameters
        return url
    }
}
