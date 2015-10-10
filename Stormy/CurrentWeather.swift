//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-08-30.
//  Copyright (c) 2015 Roberta Voulon. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage? {
        var imageName: String
        
        switch self {
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Sleet:
            imageName = "sleet.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "partly-cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "partly-cloudy-night.png"
        }
        
        return UIImage(named: imageName)
    }
}

struct CurrentWeather {
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage?
    
    init(weatherDictionary: [String:AnyObject]) {
        temperature = (weatherDictionary["temperature"] as? Int)!
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipitationFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipitationFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = (weatherDictionary["summary"] as? String)!
        
        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString) {
                
                icon = weatherIcon.toImage()
        }
        
    }
    
}