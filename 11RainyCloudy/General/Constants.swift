//
//  Constants.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

struct Constants{
    
    struct APIEndpoints{
        private static let baseUrl = "http://api.openweathermap.org/data/2.5"
        private static let latitude = "lat="
        private static let longitude = "&lon="
        private static let appId = "&appid="
        private static let apiKey = "859b35f4ea655d557cf86008852562a0"
        
        static func currentWeatherUrl(lat: Double, long: Double)-> String{
            return "\(baseUrl)/weather?\(latitude)\(lat)\(longitude)\(long)\(appId)\(apiKey)"
        }
        
        static func forecastUrl(lat: Double, long: Double)-> String{
            return "\(baseUrl)/forecast/daily?\(latitude)\(lat)\(longitude)\(long)\(appId)\(apiKey)"
        }
    }
}
