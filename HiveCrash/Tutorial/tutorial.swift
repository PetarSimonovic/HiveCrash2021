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
    
    func updateStatus() {
        switch self.status {
         case "hive":
            self.status = "flight"
        default:
            return
        }
    }
    
    func reset() {
        on = true
        status = "hive"

    }
    
    
}

