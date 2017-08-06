//
//  Extensions.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/16/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

extension Date{
    func dateOfTheWeek()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" //code the give the day of the week
        return dateFormatter.string(from: self)
    }
}

