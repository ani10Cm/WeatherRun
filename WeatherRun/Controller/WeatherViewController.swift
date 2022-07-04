//
//  ViewController.swift
//  WeatherRun
//
//  Created by Aniket Kumar on 01/07/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    var selectedCity = "Gurugram"
    let controller  = SearchViewController()
    var weatherManager = WeatherManager()

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempreatureLabel: UILabel!
    @IBOutlet weak var climateImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        weatherManager.delegate = self
        weatherManager.fetchWeather(cityName: selectedCity)
        startLoading()
        
        let date = NSDate(timeIntervalSince1970: 1415637900)
        print(date)
    }
    
    @IBAction func ChangeCityPressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeCity") as! SearchViewController
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    @IBAction func currentLocationPressed(_ sender: UIButton) {
    startLoading()
      weatherManager.fetchWeather()
    }
    
    func startLoading(){
        loadingView.isHidden = false
        spinner.startAnimating()
    }
    
    func stopLoading(){
        loadingView.isHidden = true
        spinner.stopAnimating()
    }

}

extension WeatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempreatureLabel.text = weather.temperatureString
            self.climateImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.stopLoading()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension WeatherViewController : SearchViewDelegate {
    func getTheCityName(city: String) {
        weatherManager.fetchWeather(cityName: city)
    }
    
    
}
