//
//  WeatherManager.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation



struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(by cityName: String) {
    
        var url = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
        guard let key = ApiKey.openWeatherKey else { return }
        let queryItems:[URLQueryItem] = [
            URLQueryItem(name: "appid", value: key),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "q", value: cityName)
        ]
    
        
        url?.queryItems = queryItems
        guard let urlToRequest = url?.url else { return }
        
        var request = URLRequest(url: urlToRequest)
        request.httpMethod = "POST"
    
        let networkService = NetworkService()
        
        networkService.fetchData(for: request, decodeType: OpenWeatherData.self) { (result) in
            switch result {
                case .success(let decodedData):
                    delegate?.didReceivedForecast(weatherData: decodedData)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
