//
//  Weather.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class Weather{
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemperature: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        
        return _cityName
    }
    
    var dateWithFormat: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemperature: Double{
        if _currentTemperature == nil{
            _currentTemperature = 0.0
        }
        
        return _currentTemperature
    }
    
    static func getWeatherByLocation(latitude: Double, longitude: Double, completion: @escaping(_ weather: Weather)-> Void){
        let stringUrl = Constants.APIEndpoints.currentWeatherUrl(lat: latitude, long: longitude)
        let url = URL(string: stringUrl)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print("Error when trying to get the weather info: \(error?.localizedDescription ?? "")")
                return
            }
            
            if let data = data{
                let jsonData = GeneralMethods.decodeJsonFromData(data: data)
                let weather = Weather()
                weather._cityName = (jsonData["name"] as? String)?.capitalized
                
                if let weatherInfo = jsonData["weather"] as? [[String: AnyObject]]{
                    if let mainWeather = weatherInfo[0]["main"] as? String{
                        weather._weatherType = mainWeather.capitalized
                    }
                }
                
                if let main = jsonData["main"] as? [String: AnyObject]{
                    if let temperature = main["temp"] as? Double{
                        let kelvinToFarenheitPreDivision = (temperature * (9/5) - 459.67)
                        let kelvinToFarenheit = round(10 * (kelvinToFarenheitPreDivision/10))
                        weather._currentTemperature = kelvinToFarenheit
                    }
                }
                
                completion(weather)
            }
        }.resume()
    }
}
