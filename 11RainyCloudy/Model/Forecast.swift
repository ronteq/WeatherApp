//
//  Forecast.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/16/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class Forecast{
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var dateWithFormat: String{
        if _date == nil{
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: Double{
        if _highTemp == nil{
            _highTemp = 0.0
        }
        
        return _highTemp
    }
    
    var lowTemp: Double{
        if _lowTemp == nil{
            _lowTemp = 0.0
        }
        
        return _lowTemp
    }
    
    static func getForecastByLocation(latitude: Double, longitude: Double, completion: @escaping(_ forecasts: [Forecast])-> Void){
        let stringUrl = Constants.APIEndpoints.forecastUrl(lat: latitude, long: longitude)
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
                var forecasts = [Forecast]()
                
                if let arrayJsonForecast = jsonData["list"] as? [[String: AnyObject]]{
                    for jsonForecast in arrayJsonForecast{
                        let forecast = Forecast()
                        
                        guard let date = jsonForecast["dt"] as? Double else{
                            return
                        }
                        
                        guard let temperature = jsonForecast["temp"] as? [String: AnyObject], let lowTemperature = temperature["min"] as? Double, let highTemperature = temperature["max"] as? Double else{
                            return
                        }
                        
                        guard let weather = jsonForecast["weather"] as? [[String: AnyObject]], let mainWeather = weather[0]["main"] as? String else{
                            return
                        }
                        
                        let unixConvertedDate = Date(timeIntervalSince1970: date)
                    
                        let kelvinToFarenheitPreDivisionLowTemperature = (lowTemperature * (9/5) - 459.67)
                        let kelvinToFarenheitLowTemperature = round(10 * (kelvinToFarenheitPreDivisionLowTemperature/10))
                        
                        let kelvinToFarenheitPreDivisionHighTemperature = (highTemperature * (9/5) - 459.67)
                        let kelvinToFarenheitHighTemperature = round(10 * (kelvinToFarenheitPreDivisionHighTemperature/10))
                        
                        
                        forecast._date = unixConvertedDate.dateOfTheWeek()
                        forecast._lowTemp = kelvinToFarenheitLowTemperature
                        forecast._highTemp = kelvinToFarenheitHighTemperature
                        forecast._weatherType = mainWeather
                        
                        forecasts.append(forecast)
                    }
                }
                
                completion(forecasts)
            }
            }.resume()
    }
}
