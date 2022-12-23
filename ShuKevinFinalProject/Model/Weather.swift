//
//  Weather.swift
//  ShuKevinFinalProject
//
//  Created by Kevin Shu on 11/25/22.
//

import UIKit

//need this struct to read in our JSON file
struct Weather: Decodable{
    let main: [String: Double]
    
    
    init(){
        main = [:]
    }
}
