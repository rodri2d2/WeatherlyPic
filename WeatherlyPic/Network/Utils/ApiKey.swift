//
//  ApiKey.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 20/12/20.
//

import Foundation

/**
Returns aplication APIKEY on demand
 
- Author: Rodrigo Candido
- Version: v1.0
 */
struct ApiKey {
    
    
    /// Returs OpenWeatherMap API KEY stored in the APIKEY.plist
    static var openWeatherKey: String? {
    
        if let url = Bundle.main.url(forResource:"APIKEY", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                guard let swiftDictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else { return nil}
                return swiftDictionary["openWeather"]
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
}
