//
//  Temperature.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 19/12/20.
//

import Foundation

/**
 Conforms Temperature mesurement
 
 This class conforms all temperature properties returned by OpenWeatherMap JSon object
 
 
 - Author: Rodrigo Candido
 - Version: v1.0
 */
struct Temperature: Codable {
    
    var temp:       Float
    var feels_like: Float
    var temp_min:   Float
    var temp_max:   Float
    var pressure:   Float
    var humidity:   Float
    
}
