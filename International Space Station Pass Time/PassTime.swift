//
//  JsonStructure.swift
//  International Space Station Pass Time
//
//  Created by Yugandhara Lad More on 1/15/18.
//  Copyright © 2018 Yugandhara Lad. All rights reserved.
//

import Foundation

struct PassTime {
    var duration: Double
    var risetime: Double
    
    
   init(PassTimeDict: Dictionary<String, Double>) {
       
    duration = PassTimeDict["duration"]!
    risetime = PassTimeDict["risetime"]!
    }
}


