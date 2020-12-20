//
//  OpenWeatherData.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 19/12/20.
//

import Foundation
import UIKit

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
    
    
    var weatheImage: String {
        switch self.weather[0].id {
            case 200...232:
                return Images.storm.rawValue
            case 300...321:
                return Images.drizzle.rawValue
            case 500...531:
                return Images.rain.rawValue
            case 600...622:
                return Images.snow.rawValue
            case 701...781:
                return Images.mist.rawValue
            case 801...804:
                return Images.cloud.rawValue
            default:
                return Images.clear.rawValue
        }
    }
    
}
