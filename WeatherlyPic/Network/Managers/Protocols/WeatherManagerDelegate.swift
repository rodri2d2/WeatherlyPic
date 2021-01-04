//
//  WeatherManagerDelegate.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation


protocol WeatherManagerDelegate {
    
    func didReceivedForecast(weatherData: OpenWeatherData)
    
}
