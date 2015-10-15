//
//  Forecast.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-10-14.
//  Copyright © 2015 Roberta Voulon. All rights reserved.
//

import Foundation

// Wrapper for CurrentWeather and DailyWeather

struct Forecast {
    var currentWeather: CurrentWeather?
    var weekly: [DailyWeather] = []
    
    init(weatherDictionary: [String: AnyObject]?) {
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }
        if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]] {
            for dailyWeather in weeklyWeatherArray {
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        }
    }
}