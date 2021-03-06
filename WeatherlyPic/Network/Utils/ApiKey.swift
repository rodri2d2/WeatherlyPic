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
                guard let apiDictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else { return nil}
                return apiDictionary["openWeather"]
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    /// Returs Unsplash API KEY stored in the APIKEY.plist
    static var unsplashAccess: String? {
    
        if let url = Bundle.main.url(forResource:"APIKEY", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                guard let apiDictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else { return nil}
                return apiDictionary["unsplashAccess"]
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    /// Returs Unsplash API KEY stored in the APIKEY.plist
    static var unsplashKey: String? {
    
        if let url = Bundle.main.url(forResource:"APIKEY", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                guard let apiDictionary = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else { return nil}
                return apiDictionary["unsplashAccess"]
                
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
}
