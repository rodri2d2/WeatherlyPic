//
//  WeatherManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 20/12/20.
//

import Foundation
import UIKit


/**
Network Manager for OpenWeatherMap
 
Use this class to retrieve and translate all data from Weather API
 
- Author: Rodrigo Candido
- Version: v1.0
 */
struct WeatherNetworkManager {

    /// Make a request with **city name** parameter
    /// - Parameters:
    ///   - name: String - The name of the city to fetch a weather
    ///   - completion: What to do once fetch data is finish successfully or not
    func fetchWeather(byCity name: String, completion: @escaping (Result<OpenWeatherData?, WeatherError>) -> Void){
        
        guard let key = ApiKey.openWeatherKey else { return }
        
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "q", value: name)
        ]
        
        guard let urlComponent = self.baseURL(byParameters: queryItems),
              let url = urlComponent.url else { return }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in

            let decoder = JSONDecoder()
            guard let data = data else {return}

            do{
                let decodedData = try decoder.decode(OpenWeatherData.self, from: data)
                completion(.success(decodedData))
            }catch{

            }

        }
        
        task.resume()
    }
    
}


// MARK: - Extension for RequestConfigurationProtocol
extension WeatherNetworkManager: RequestConfigurationProtocol{
    
    func baseURL(byParameters parameters: [URLQueryItem]?) -> URLComponents? {
        guard var url = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather") else {
            return nil
        }
        
        url.queryItems  = parameters
        return url
    }
}
