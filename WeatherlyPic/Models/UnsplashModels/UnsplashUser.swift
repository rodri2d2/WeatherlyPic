//
//  UnsplashUser.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 22/12/20.
//

import Foundation

/**
 
A representation of user from Unsplash API
 
This class represents the User type inside Unsplash reponse
This class does not match exactly with Results response
 
- Author: Rodrigo Candido
- Version: v1.0
 
 */
struct UnsplashUser: Codable {
    
    var id:     String
    var name:   String
}
