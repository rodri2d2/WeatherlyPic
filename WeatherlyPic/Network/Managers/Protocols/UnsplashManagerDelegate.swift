//
//  UnsplashMangerDelegate.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 4/1/21.
//

import UIKit

/// The methods that you use to receive events from an associated UnsplashManager object.
protocol UnsplashManagerDelegate {
    
    func didFetchUnsplashData(unsplashData: UnsplashData)
    func didFetchImage(image: UIImage)
    
    
}
