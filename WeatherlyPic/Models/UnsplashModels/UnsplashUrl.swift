//
//  UnsplashUrl.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 23/12/20.
//

import Foundation

/**
 
A representation of Urls from Unsplash API
 
This class represents the Urls type inside Unsplash reponse
This class uses only a url thar point to a full image size
 
- Author: Rodrigo Candido
- Version: v1.0
 
 */
struct UnsplashUrl: Codable {
    
    var full: String
 
}
