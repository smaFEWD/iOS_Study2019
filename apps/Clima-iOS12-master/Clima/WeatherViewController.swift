//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // Apple's library to use the phone's GPS
import Alamofire // to handle the https requests - see: ( https://github.com/Alamofire/Alamofire )
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "8336087686f606d59ea3f5bd51b52ba5"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager() // declaring a new object from the CLLocationManager class
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
    
        // this first one below is so that the locationManger that Apple coded up can deal with the location related functionality.
        // with a "delegate" whatever location that we can find, via the locationManger(from Apple), it can allow /work with our own viewController (which is not coded up by Apple.)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // this is an Asynchronous method, working in the background
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the weather data!")
                // converting it into JSON is b/c of the SwiftyJSON pod --not SWIFT alone
                // using "!" to force unwrap and we know that it's indeed a successful response since we have a check with the "if" statement
                
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                // this will result in a closure and when you see response "in" above...you know you are inside a closure. So need to use "self" in front of this method.
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Conection Issues" // updating the user on the app about an error
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON){
        if let tempResult = json["main"]["temp"].double {
        weatherDataModel.temperature = Int((tempResult - 273.15)*(9/5)+32)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }

    }
    //MARK: - UI Updates
    /***************************************************************/
        
        
        //Write the updateUIWithWeatherData method here:
        func updateUIWithWeatherData() {
            cityLabel.text = weatherDataModel.city
            temperatureLabel.text = "\(weatherDataModel.temperature)°"
            weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        }

 
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    // tells the delegate that new info is available
    // this is the method that gets activated once the locationManager has found a location
    // once it finds a location it will send it to the array [CLLocation] and the last value sent is the most accurate, so the code below will want the last value entered into the array.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1] // the last location and the most accurate

        // we need to check the location is "valid" and since this is so battery intensive, as soon as there is a valid result, we should stop the process - we want to do this whenever we use locationManager on GPS results
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            // this means after it is stopped updating, we want it to not print the data more than once to console
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
        
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
    }
    
    
    
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error) // printing error to the console
        // we also want to tell the user that there was an error
        cityLabel.text = "Location Unavailable"
    }
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    func userEnteredANewCityName(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self 
        }
    }
    
    
    
    
}



