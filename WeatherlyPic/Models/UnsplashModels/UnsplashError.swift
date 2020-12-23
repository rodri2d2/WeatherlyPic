//
//  UnsplashErrors.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 23/12/20.
//

import Foundation

/**
Use this to conform with Result Pattern
 

- Author: Rodrigo Candido
- Version: v1.0
 */
enum UnsplashError:String, Error{
    
    case queryIsMissing = "Query is missing"
    
}
