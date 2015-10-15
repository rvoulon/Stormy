//: Playground - noun: a place where people can play

import UIKit
import Foundation

let dateFormatter = NSDateFormatter()

func timeStringFromUnixTime(unixTime: Double) -> String {
    let date = NSDate(timeIntervalSince1970: unixTime)
    
    // Returns time formatted as 24h time
    return dateFormatter.stringFromDate(date)
    
}
