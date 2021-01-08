//
//  UnsplashData.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 22/12/20.
//


import Foundation

/**
 
 Unsplash class to use as an Usplash JSON translator
 
 This class represents only the needed data for this application.
 This class does not match exactly with Unsplash JSON Response.
 

 
- Author: Rodrigo Candido
- Version: v1.0
 
- Attention: For more information about json response check out the official documentation https://unsplash.com/documentation
 
 */
struct UnsplashData: Codable {
    
    enum CodingKeys: String, CodingKey  {
        case total      = "total"
        case totalPages = "total_pages"
        case results    = "results"
    }
    
    let total:      Int
    let totalPages: Int
    let results:    [UnsplashResult]

}
