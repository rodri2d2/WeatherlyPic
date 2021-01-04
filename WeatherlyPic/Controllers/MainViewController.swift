//
//  MainViewController.swift
//  WeatherlyPic
//
//  Created by Rodrigo Candido on 18/12/20.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var cityNameErrorCount = 0
    var arrayOfImages   = [String]()
    var weatherManager  = WeatherManager()
    var unsplashManager = UnsplashManager()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var weatherIcon:     UIImageView!
    @IBOutlet weak var backGroundImage:         UIImageView!
    @IBOutlet private weak var cityNameLabel:   UILabel!
    @IBOutlet weak var cityNameTextField:       UITextField!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        setupCityNameTextField()
        
        //
        weatherManager.delegate     = self
        unsplashManager.delegate    = self
    }
    
    
    // MARK: - IBActions
    @IBAction func didPressedSearch(_ sender: UIButton) {
        prepareToRequestByCity()
    }
    
    
    // MARK: - Class functionalities
    
    /**
     This method check if cityNameTextField has a value.
     Otherwise it will increment a count and throw a error few tries later
     If cityNameTextField has a value it will call a doRequest method sending text value
     
     - Attention: A ManagerClass is responsible to handle its response errors such as INVALID CITY NAME
     */
    private func prepareToRequestByCity(){
        
        self.cityNameTextField.resignFirstResponder()
        
        if (cityNameErrorCount < 3){
            guard let cityName = cityNameTextField.text, !cityNameTextField.text!.isEmpty else{
                self.cityNameErrorCount += 1
                return
            }
            weatherManager.fetchWeather(by: cityName)
            
        }else{
            
            let alert   = UIAlertController(title: "Oops..!", message: "Please enter your city name", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK!", style: .default) { [weak self] (_) in
                self?.cityNameErrorCount = 0
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    // MARK: - Class UI functionalities
    /// Update UI elements
    /// - Parameter weatherData: the object that contains weather info
    private func updateUI(weatherData: OpenWeatherData){
        
        
        
        DispatchQueue.main.async {
            self.weatherIcon.image = UIImage(systemName: weatherData.weatherImage)
            self.cityNameTextField.text = ""
            self.cityNameLabel.text = weatherData.name
            self.temperatureLabel.text = "\(weatherData.main.temp)"
        }
        
        self.unsplashManager.fetchImageData(for: weatherData.weather.first!.main) { (result) in
            switch result{
                case .success(let unsplashData):
                    guard let url = unsplashData?.results.randomElement()?.url.full else {return}
                    self.unsplashManager.fetchImage(with: url)
                case .failure(_):
                    print("NOK")
            }
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
    func didReceivedForecast(weatherData: OpenWeatherData) {
        self.updateUI(weatherData: weatherData)
    }
}


// MARK: - Extension for UnsplashManagerDelegate
extension MainViewController: UnsplashManagerDelegate{
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
