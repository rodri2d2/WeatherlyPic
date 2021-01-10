//
//  WeatherManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation
import CoreLocation



struct WeatherManager {
    
    private let networkService = NetworkService()
    var delegate: WeatherManagerDelegate?
    private var url = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
    private var key: String?
    
    init() {
        
        guard let apikey = ApiKey.openWeatherKey else { return }
        self.key = apikey
    }
    
    /// Creates a request to call Weather API passing a City Name
    /// - Parameter cityName: as String
    mutating func prepareResquest(by cityName: String) -> URLRequest?{
    
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "q", value: cityName)
        ]
        url?.queryItems = queryItems
        guard let urlToRequest = url?.url else { return nil}
        
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "POST"

        return request
        
    }
    
    
    /// Creates a request to call Weather API passing Lat&Long coordinates
    /// - Parameter coodidantes: as CLLocationCoordinate2D
    mutating func prepareResquest(by coordinate: CLLocationCoordinate2D) -> URLRequest? {

        guard let lat = coordinate.latitude.description as String?,
              let lon = coordinate.longitude.description as String? else { return nil}
        
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
        ]
        
        url?.queryItems = queryItems
        guard let urlToRequest = url?.url else { return nil}
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "POST"
        
        return request
        
    }
    
    
    
    /// Make a request to the Weather API
    /// The result is returned usign a WeatherManagerDelegate on the MainQueue
    /// - Parameter request: as URLRequest
    func fetchWeather(for request: URLRequest){
        
        networkService.fetchData(for: request, decodeType: OpenWeatherData.self) { (result) in
            switch result {
                case .success(let decodedData):
                    DispatchQueue.main.async {
                        delegate?.didReceiveForecast(weatherData: decodedData)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
