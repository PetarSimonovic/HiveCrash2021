//
//  tutorial.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 03/08/2021.
//

import Foundation

class Tutorial {
    
    var on: Bool = true
    var status: String = "hive"
    var firstBee: Bool = true
    var firstFlower: Bool = true
    
    
    func updateStatus() {
        switch self.status {
         case "hive":
            self.status = "flight"
        case "flight":
            self.firstBee = false
            self.status = "flower"
        case "flower":
            self.firstFlower = false
            self.status = "pollen"
        case "pollen":
            self.status = "finished"
        default:
            return
        }
    }
    
    func reset() {
        self.on = true
        self.status = "hive"
        self.firstBee = true
        self.firstFlower = true

    }
    
    
}

