//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-10-05.
//  Copyright © 2015 Roberta Voulon. All rights reserved.
//

import Foundation

class NetworkOperation {

    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = [String: AnyObject]? -> Void
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check http response for successful GET request
            
            // Optional binding here:
            // Why cast NSURLResponse to NSHTTPURLResponse? The former doesn't have
            // a status code property, but with the latter we can access status codes.
            if let httpResponse = response as? NSHTTPURLResponse {
                switch (httpResponse.statusCode) {
                case 200:
                    // 2. Create JSON object with data
                    do {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                        completion(jsonDictionary)
                    // Pasan's code
                    } catch {
                        completion(nil)
                    }

                    /*
                    My original code:
                    } catch let error {
                        print("JSON Serialization failed. Error: \(error)")
                    }
                    */
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid http response")
            }
        }
        
        dataTask.resume()

    }
}