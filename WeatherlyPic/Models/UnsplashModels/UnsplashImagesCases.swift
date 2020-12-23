//
//  ImagesCases.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 23/12/20.
//

import Foundation


/**

Type of images that will be fetched in a UnsplashManager
 
- Author: Rodrigo Candido
- Version: v1.0
*/
enum UnsplashImageCase: String {
    
    case clear      = "sunny"
    case cloud      = "cloudy"
    case rain       = "rain"
    case storm      = "storm"
    case drizzle    = "showering rain"
    case snow       = "snow"
    case mist       = "fog"
    
}
