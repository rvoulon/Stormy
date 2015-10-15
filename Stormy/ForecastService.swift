//
//  ForecastService.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-10-08.
//  Copyright © 2015 Roberta Voulon. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    /*
    I'm still not sure about the syntax of the () in method type signatures
    In the videos they sometimes leave out the () around the parameters (if
    they are indeed parameters?), and sometimes they wrap the whole signature in ().
    Inconsistencies? Or they really don't mean the same thing?
    Started poking around in the documentation...
    */
    typealias getForecastCompletion = Forecast? -> Void
    
    init(APIKey: String) {
        // No need to prefix these with "self." in Swift (in Objective-C you would).
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    
    
    func getForecast(lat lat: Double, long: Double, completion: (getForecastCompletion)) {
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL() {
                (let jsonDictionary) in
                let forecast = Forecast(weatherDictionary: jsonDictionary)
                completion(forecast)
            }
            
        } else {
            print("Could not construct a valid URL")
        }
    }
    
//    func getCurrentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
//        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
//            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
//        } else {
//            print("jsonDictionary returned nil for 'currently' key")
//            return nil
//        }
//    }
}








