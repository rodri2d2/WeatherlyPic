//
//  WeatherManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation
import CoreLocation



struct WeatherManager {
    
    let networkService = NetworkService()
    var delegate: WeatherManagerDelegate?
    var url = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
    var key: String?
    
    init() {
        
        guard let apikey = ApiKey.openWeatherKey else { return }
        self.key = apikey
    }
    
    /// Creates a request to call Weather API passing a City Name
    /// - Parameter cityName: as String
    mutating func fetchWeather(by cityName: String) {
    
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "q", value: cityName)
        ]
        url?.queryItems = queryItems
        guard let urlToRequest = url?.url else { return }
        
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "POST"

        self.doFecthData(for: request)
        
    }
    
    
    /// Creates a request to call Weather API passing Lat&Long coordinates
    /// - Parameter coodidantes: as CLLocationCoordinate2D
    mutating func fetchWeather(by coordinate: CLLocationCoordinate2D) {

        guard let lat = coordinate.latitude.description as String?,
              let lon = coordinate.longitude.description as String? else { return }
        
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon)
        ]
        
        url?.queryItems = queryItems
        guard let urlToRequest = url?.url else { return }
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "POST"
        
        self.doFecthData(for: request)
    }
    
    
    
    /// Make a request to the Weather API
    /// - Parameter request: as URLRequest
    private func doFecthData(for request: URLRequest){
        
        networkService.fetchData(for: request, decodeType: OpenWeatherData.self) { (result) in
            switch result {
                case .success(let decodedData):
                    delegate?.didReceiveForecast(weatherData: decodedData)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
