//
//  SavedBee.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/07/2021.
//

import Foundation


struct SavedBee: Decodable, Encodable {
    
   var id = UUID()
   var name: String
   var birthday = Date()
   var type: String
   var pollen: Int = 0
   var battlesWon: Int = 0
   var battlesFought: Int = 0
   var levelsCompleted: Int = 0
   var flowersVisited: Int = 0
    var flights: Int = 0
    
    init(_ name: String, _ type: String) {
        self.name = name
        self.type = type
    }
    
}

