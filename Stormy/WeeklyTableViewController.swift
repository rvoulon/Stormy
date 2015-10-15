//
//  WeeklyTableViewController.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-10-13.
//  Copyright © 2015 Roberta Voulon. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentLocationLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    
    private let forecastAPIKey = "6e569955c6f31e16711573389b862cb0"
    let coordinate: (lat: Double, long: Double) = (45.5000,-73.5833)
    
    var weeklyWeather: [DailyWeather] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        // Set tableView's background view property
        tableView.backgroundView = BackgroundView()
        
        // Set custom height for table view row
        tableView.rowHeight = 64
        
        // Change the font and size of nav bar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let navBarAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navBarFont
            ]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
        
        // Position refresh control above background view
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDaily" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dailyWeather = weeklyWeather[indexPath.row]
                
                (segue.destinationViewController as! ViewController).dailyWeather = dailyWeather
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> DailyWeatherTableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as? DailyWeatherTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature {
            cell?.temperatureLabel?.text = "\(fahrenheitToCelsius(maxTemp))º"
        }
        cell?.weatherIcon?.image = dailyWeather.icon
        cell?.dayLabel?.text = dailyWeather.day
        
        return cell!
    }
    
    // MARK: - Delegate Methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 170/255, green: 131/255, blue: 225/255, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 165/255, green: 142/255, blue: 203/255, alpha: 1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 165/255, green: 142/255, blue: 203/255, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
    }

    // MARK: - Weather Fetching

    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(lat: coordinate.lat, long: coordinate.long) {
            (let forecast) -> Void in
            
            if let weatherForecast = forecast,
            let currentWeather = weatherForecast.currentWeather
            {
                // Update UI (get back on the main thread)
                dispatch_async(dispatch_get_main_queue()) {
                    () -> Void in
                    // Execute closure (will happen on the main queue)
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(self.fahrenheitToCelsius(temperature))º"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLabel?.text = "Precipitation: \(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature {
                            
                            self.currentTemperatureRangeLabel?.text = "↑\(self.fahrenheitToCelsius(highTemp))º ↓\(self.fahrenheitToCelsius(lowTemp))º"
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func fahrenheitToCelsius(fahrenheit: Int) -> Int {
        return (fahrenheit - 32) * 5 / 9
    }

}
