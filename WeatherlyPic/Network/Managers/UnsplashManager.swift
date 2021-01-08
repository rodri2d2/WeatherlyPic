//
//  UnsplashManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation
import UIKit


struct UnsplashManager {
    
    var delegate: UnsplashManagerDelegate?
   
    
    /// Make a request to Unsplash API.
    /// The sended resquest asks for a Key word: e.g.: Clouds, Sunny, Haze etc..
    /// The complition returns the result for this search
    /// - Parameters:
    ///   - imageCase: as String
    ///   - completion: as (Result<UnsplashData?, UnsplashError>) -> Void)
    func fetchImageData(for imageCase: String, completion: @escaping (Result<UnsplashData?, UnsplashError>) -> Void) {
    
        guard let key = ApiKey.unsplashAccess else { return }
        var url = URLComponents(string: "https://api.unsplash.com/search/photos")
        
        
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "query", value: imageCase),
            URLQueryItem(name: "client_id", value: key)
        ]
        
        url?.queryItems = queryItems
        
        guard let urlToRequest = url?.url else { return  }
        
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "GET"
        
    
        let networkService = NetworkService()
        networkService.fetchData(for: request, decodeType: UnsplashData.self) { (result) in
            switch result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    /// Make a request and translate data type to an image
    /// Once the request has finished, it calls its delegate method - didFetchImage - passing a UIImage Object
    /// - Parameter imageUrl: as String
    func fetchImage(with imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else { return }
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    delegate?.didFetchImage(image: image)
                }
            }
        }
    }
    
    
}
