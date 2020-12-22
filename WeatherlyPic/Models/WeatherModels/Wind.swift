//
//  Wind.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 19/12/20.
//

import Foundation

/**
 Conforms to a OpenWeatherMap wind representation.
 

 - Author: Rodrigo Candido
 - Version: v1.0
 */
struct Wind: Codable {
    var speed:  Float
    var deg:    Float
}
