//
//  MainViewController.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 18/12/20.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    

            
        //
        doRequestWeatherData()
    }
    
    
    // MARK: - Class functionalities
    
    /// Fetch a weather request to its manager
    private func doRequestWeatherData(){
        
        let weatherManager = WeatherNetworkManager()
        weatherManager.fetchWeather(byCity: "Irun") { [weak self] (result) in
            
            switch result{
                case .success(let weatherData):
                    self?.updateUI(weatherData: weatherData!)
                case .failure(let error):
                    print(error)
            }
            
        }
        
    }
    
    // MARK: - Class UI functionalities
    
    
    /// Update UI elements
    /// - Parameter weatherData: the object that contains weather info
    private func updateUI(weatherData: OpenWeatherData){
        
        DispatchQueue.main.async {
            self.tempLabel.text = String(weatherData.main.temp)
        }
        
       
    }
    
    
    
    
}
