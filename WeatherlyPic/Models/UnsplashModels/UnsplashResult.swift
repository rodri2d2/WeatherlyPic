//
//  Result.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 22/12/20.
//

import Foundation

/**
 
 Unsplash class to use as an Usplash Result JSON translator
 
 This class represents the Results array inside Unsplash reponse
 This class represents a array that does not match exactly with Results response
 

 
- Author: Rodrigo Candido
- Version: v1.0
 
- Attention: For more information about json response check out the official documentation https://unsplash.com/documentation
 
 */
struct UnsplashResult: Codable {
    
    
    enum CodingKeys: String, CodingKey  {
        case id          = "id"
        case description = "description"
        case url         = "urls"
        case user       = "user"
    }
    
    var id:          String
    var description: String?
    var url:         UnsplashUrl
    var user:        UnsplashUser
    
}
