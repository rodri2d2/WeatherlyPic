//
//  Weather.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 19/12/20.
//

import Foundation

/**
 Conforms Weather representation
 
 This class conforms the OpenWeatherMap JSon object and its weather representation.
 
 - Important: Main propertie returns a one word weather description.
E.g.: Today is a **Cloudy** day.
Description propertie its a decribed sentence.
E.g.: **Broken Clouds**
 
 - Author: Rodrigo Candido
 - Version: v1.0
 */
struct Weather: Codable {
    
    var main:           String
    var description:    String

}
