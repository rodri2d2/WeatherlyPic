//
//  RequestConfigurationProtocol.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 20/12/20.
//

import Foundation

/**
To generate a base url
 
All network managers should implement this protocol to asure that the manager class conforms to all requirements for a request
 
- Author: Rodrigo Candido
- Version: v1.0
 */
protocol RequestConfigurationProtocol {
    
    func baseURL(byParameters parameters:[URLQueryItem]?) -> URLComponents?
    
}
