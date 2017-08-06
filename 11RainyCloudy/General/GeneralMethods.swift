//
//  GeneralMethods.swift
//  11RainyCloudy
//
//  Created by Daniel Fernandez on 6/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class GeneralMethods{
    static func decodeJsonFromData(data: Data)-> [String: AnyObject]{
        var json = [String: AnyObject]()
        
        do{
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
        }catch{
            print("Error when trying to convert to JSON: \(error.localizedDescription)")
        }
        
        return json
    }
    
    static func decodeArrayJsonFromData(data: Data)-> [[String: AnyObject]]{
        var arrayJson = [[String: AnyObject]]()
        
        do{
            arrayJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: AnyObject]]
        }catch{
            print("Error when trying to convert to JSON: \(error.localizedDescription)")
        }
        
        return arrayJson
    }
}
