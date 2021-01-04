//
//  NetworkManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 24/12/20.
//

import Foundation

/**
 This class handles all Network requests
 
 Instead of make a class to request data for all type of datas needed in this app. This class handles all network and delegation process by a unique method fetchData which asks for a URlResquest, a Data Type to be decoded and once the task is complete execute a complition closure
 
 
 - Author: Rodrigo Candido
 - Version: v1.0
 */
class NetworkService: NSObject {
    
    func fetchData<T>(for request: URLRequest, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        
        let session = URLSession(configuration: .default)
    
            let task    = session.dataTask(with: request) { (data, response, error) in
                
                let decoder = JSONDecoder()
                guard let data = data else {return}
                
                do{
                    let decodedData = try decoder.decode(decodeType, from: data)
                    completion(.success(decodedData))
                }catch{
                    
                }
            }
            task.resume()
    }
}
