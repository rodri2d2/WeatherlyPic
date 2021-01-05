//
//  WeatherManagerDelegate.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 26/12/20.
//

import Foundation


/// The methods that you use to receive events from an associated WeatherManager object.
protocol WeatherManagerDelegate {
    
    func didReceiveForecast(weatherData: OpenWeatherData)
    
}
