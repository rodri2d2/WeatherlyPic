//
//  WeatherErrors.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 20/12/20.
//

import Foundation

/**
Use this to conform with Result Pattern
 

- Author: Rodrigo Candido
- Version: v1.0
 */
enum WeatherError:String, Error{

    case cityNotFound       = "City not found"
    case invalidApiKey      = "Invalid API Key"
    case nothingToGeocode   = "Nothing to Geo Code"
    
}
