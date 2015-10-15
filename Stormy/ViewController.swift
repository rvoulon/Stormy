//
//  ViewController.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-08-30.
//  Copyright (c) 2015 Roberta Voulon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dailyWeather: DailyWeather? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var sunriseTimeLabel: UILabel?
    @IBOutlet weak var sunsetTimeLabel: UILabel?
    
    @IBOutlet weak var lowTemperatureLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let weather = dailyWeather {
            // Update UI with information from the data model
            self.title = weather.day
            weatherIcon?.image = weather.largeIcon
            summaryLabel?.text = weather.summary
            sunriseTimeLabel?.text = weather.sunriseTime
            sunsetTimeLabel?.text = weather.sunsetTime
            
            if let lowTemp = weather.minTemperature,
                let highTemp = weather.maxTemperature,
                let precipitation = weather.precipChance,
                let humidity = weather.humidity {
                    lowTemperatureLabel?.text = "\(fahrenheitToCelsius(lowTemp))º"
                    highTemperatureLabel?.text = "\(fahrenheitToCelsius(highTemp))º"
                    precipitationLabel?.text = "\(precipitation)%"
                    humidityLabel?.text = "\(humidity)%"
            }
        }
        
        // Configure nav bar back button
        if let barButtonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let barButtonAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: barButtonFont
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    // MARK: - Helper Methods
    
    func fahrenheitToCelsius(fahrenheit: Int) -> Int {
        return (fahrenheit - 32) * 5 / 9
    }
    
}





