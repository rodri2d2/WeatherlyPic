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
    
    
    
    
    /**
        Computed property that returns **last** avaible icon
        By doing this way if the weather changes during the day
        The user will see the equivalent icon for the last/actual weather condition
     */
    var weatheImage: String {
        
        let id = self.weather.last?.id ?? self.weather[0].id
        
        switch id{
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
