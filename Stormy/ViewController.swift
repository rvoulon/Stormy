//
//  ViewController.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-08-30.
//  Copyright (c) 2015 Roberta Voulon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTempLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentRainLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let forecastAPIKey = "6e569955c6f31e16711573389b862cb0"
    let coordinate: (lat: Double, long: Double) = (45.5000,-73.5833)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func fahrenheitToCelsius(fahrenheit: Int) -> Int {
        return (fahrenheit - 32) * 5 / 9
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(lat: coordinate.lat, long: coordinate.long) {
            (let currently) -> Void in
            
            if let currentWeather = currently {
                // Update UI (get back on the main thread)
                dispatch_async(dispatch_get_main_queue()) {
                    () -> Void in
                    // Execute closure (will happen on the main queue)
                    if let temperature = currentWeather.temperature {
                        self.currentTempLabel?.text = "\(self.fahrenheitToCelsius(temperature))º"
                    }
                    
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentRainLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = "\(summary)"
                    }
                    
                    self.toggleRefreshAnimation(false)
                }
            }
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
    }
    
}





