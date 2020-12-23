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
    let unsplashManager = UnsplashNetworkManager()
    var arrayOfImages   = [String]()
    

    // MARK: - IBOutlets
    @IBOutlet private weak var weatherIcon:     UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet private weak var cityNameLabel:   UILabel!
    @IBOutlet weak var cityNameTextField:       UITextField!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        setupCityNameTextField()
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
            
            doRequestWeatherData(byCity: cityName)
            
        }else{
            
            let alert   = UIAlertController(title: "Oops..!", message: "Please enter your city name", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK!", style: .default) { [weak self] (_) in
                self?.cityNameErrorCount = 0
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
 
        }
    }
    
    /// Fetch a weather request to its manager
    private func doRequestWeatherData(byCity name: String){
        
        let weatherManager = WeatherNetworkManager()
        weatherManager.fetchWeather(byCity: name) { [weak self] (result) in
            switch result{
                case .success(let weatherData):
                    self?.updateUI(weatherData: weatherData!)
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    private func prepareToDownloadImage(for condition: String){
        downloadBackgroundImages(image: condition)
    }
    
    
    private func downloadBackgroundImages(image type: String){
        
        unsplashManager.fetchUsplashImagesData(by: type) { [weak self] (result) in
        
            guard let self = self else {return}
            
            switch result{
                case .success(let unsplashData):
                    guard let unsplashData = unsplashData else { return }
                    self.prepareArrayOfImages(from: unsplashData)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
    private func prepareArrayOfImages(from unsplashData: UnsplashData){
        
        arrayOfImages.removeAll()
        
        for item in unsplashData.results {
            self.arrayOfImages.append(item.url.full)
        }
        
        updateBackground()
    }
    
    
    
    // MARK: - Class UI functionalities
    /// Update UI elements
    /// - Parameter weatherData: the object that contains weather info
    private func updateUI(weatherData: OpenWeatherData){
        
        DispatchQueue.main.async {
            self.weatherIcon.image = UIImage(systemName: weatherData.weatherImage)
            self.cityNameTextField.text = ""
            self.cityNameLabel.text = weatherData.name
            self.prepareToDownloadImage(for: weatherData.weather.last!.main)
        }

    }
    
    
    private func updateBackground(){
        
        let numberOfUrls = arrayOfImages.count
        
        let imageIndex = Int.random(in: 0..<numberOfUrls)
        
        unsplashManager.fetchImages(url: arrayOfImages[imageIndex] ?? "") { (result) in
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                    
                        UIView.animate(withDuration: 3) { [weak self] in
                            
                            self?.backGroundImage.alpha = 0
                            
                        }
                        
                        UIView.animate(withDuration: 3) { [weak self] in
                            self?.backGroundImage.image = image
                            self?.backGroundImage.alpha = 1
                        }
                    }
                case .failure(_):
                    print("oops.. no se puede cargar imagen!")
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
