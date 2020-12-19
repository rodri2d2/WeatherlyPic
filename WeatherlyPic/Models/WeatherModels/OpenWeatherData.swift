//
//  OpenWeatherData.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 19/12/20.
//

import Foundation


/**
 
 Weather Condition class to use as an OpenWeatherMap JSON translator
 
 This class represents not only an entire Weather condition, but also a Coordinate object that can be use to send as a location.
 This class does not match exactly with OpenWetherMap Json respose.
 

 
- Author: Rodrigo Candido
- Version: v1.0
 
- Attention: For more information about json response check out the official documentation https://openweathermap.org/current
 
 */
struct OpenWeatherData: Codable {
    
    var name:    String
    var main:    Temperature
    var weather: [Weather]
    var coord:   Coordinate
    var wind:    Wind
    
}
