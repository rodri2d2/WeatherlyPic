//
//  MainViewController.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 18/12/20.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var imagesDictionary    = [String: [String]]()
    var lastKey             = ""//To keep last value untill different API call
    var weatherManager      = WeatherManager()
    var unsplashManager     = UnsplashManager()
    let locationManager     = CLLocationManager()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var  weatherIcon:        UIImageView!
    @IBOutlet weak var          backGroundImage:    UIImageView!
    @IBOutlet private weak var  cityNameLabel:      UILabel!
    @IBOutlet weak var          cityNameTextField:  UITextField!
    @IBOutlet weak var temperatureLabel:            UILabel!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup all Managers delegates
        locationManager.delegate    = self
        weatherManager.delegate     = self
        unsplashManager.delegate    = self
        
        //Request permition to user location
        locationManager.requestWhenInUseAuthorization()
        
        //Resquest a location
        locationManager.requestLocation()
        
        //Setup City Name text field to specify its properties
        setupCityNameTextField()

    }
    
    
    // MARK: - IBActions
    
    /// Search button was pressed
    /// - Parameter sender: type UIButton
    @IBAction func didPressSearch(_ sender: UIButton) {
        prepareToRequestByCity()
    }
    
    
    /// Compass button was pressed
    /// - Parameter sender: type UIButton
    @IBAction func didPressLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    // MARK: - Class functionalities
    
    /**
     This method check if cityNameTextField has a value.
     If cityNameTextField has a value it will call a doRequest method sending text value
     
     - Attention: A ManagerClass is responsible to handle its response errors such as INVALID CITY NAME
     */
    private func prepareToRequestByCity(){
        
        self.cityNameTextField.resignFirstResponder()
        guard let cityName = cityNameTextField.text, !cityNameTextField.text!.isEmpty else { return }
        if let request = weatherManager.prepareResquest(by: cityName){
            weatherManager.fetchWeather(for: request)
        }
    }
    
    /// This method checks if there is already a set of URL in a dictionary.
    /// Otherwise it will fetch photos API to generate this set of URL
    /// - Parameter imageKey: as String
    private func requestBackgroundImage(for imageKey: String){
        
        if let imageToFetch = imagesDictionary[imageKey]?.randomElement() {
            unsplashManager.fetchImage(for: imageToFetch)
        }else{
            lastKey = imageKey
            imagesDictionary[imageKey] = []
            unsplashManager.fetchImageData(for: imageKey)
        }
    }

    private func setupCityNameTextField(){

        self.cityNameTextField.delegate         = self
        self.cityNameTextField.textContentType  = .addressCity
        self.cityNameTextField.returnKeyType    = .done
        self.cityNameTextField.clearButtonMode  = .always

    }
}

// MARK: - Extention for UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cityNameTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        prepareToRequestByCity()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}


// MARK: - Extension for WeatherManagerDelegate
extension MainViewController: WeatherManagerDelegate {
    func didReceiveForecast(weatherData: OpenWeatherData) {
       
        self.weatherIcon.image      = UIImage(systemName: weatherData.weatherImage)
        self.cityNameTextField.text = ""
        self.cityNameLabel.text     = weatherData.name
        self.temperatureLabel.text  = "\(weatherData.main.temp)"
        
        guard let imageKey = weatherData.weather.last?.main else {return}
        self.requestBackgroundImage(for: imageKey)
    }
}


//// MARK: - Extension for UnsplashManagerDelegate
extension MainViewController: UnsplashManagerDelegate{
    
    func didFetchUnsplashData(unsplashData: UnsplashData) {
        
        for item in unsplashData.results {
            imagesDictionary[lastKey]?.append(item.url.full)
        }
        
        requestBackgroundImage(for: lastKey)

    }
    
    func didFetchImage(image: UIImage) {
        DispatchQueue.main.async {

            UIView.animate(withDuration: 2) {
                self.backGroundImage.alpha = 0
            }

            UIView.animate(withDuration: 2) {
                self.backGroundImage.image = image
                self.backGroundImage.alpha = 1
            }
        }
    }
}

// MARK: - Extension for CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.last?.coordinate else { return  }
        guard let resquest = weatherManager.prepareResquest(by: coordinates) else {return}
        self.locationManager.stopUpdatingLocation()
        self.weatherManager.fetchWeather(for: resquest)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
